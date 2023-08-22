class EventsController < ApplicationController

  include AssociationAdminsHelper

  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ new create edit update destroy ]

  def new
    if params[:division]
      @division = Division.find(params[:division]) 
      @event = @division.events.build
    else
      @event = Event.new
    end 

  end

  def edit

    @circuits = Circuit.all.order(:pays) 

    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@event, 
          partial: "events/form", 
          locals: {event: @event})
      end
    end
  end

  def create
  
    @event = Event.new(event_params)

    @circuits = Circuit.all.order(:pays) 
    
    respond_to do |format|

      
      if @event.save
               
        if current_user && verif_admin_ligue(current_user, @event.division.saison.ligue)

          format.html { 
            redirect_to menu_index_path(
              ligue: @event.division.saison.ligue, 
              saison: @event.division.saison.id, 
              division: @event.division.id,
              event: @event.id
            ), notice: "event was successfully created" }
          
          format.json { render :show, status: :created, location: @event }

        else
          redirect_to root_path, notice: "not authorized action"
        end 
      else

        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace(
            'new_event', partial: 'events/form', locals: { event: @event }
        ) }


        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        flash.now[:success] = "event was successfully updated"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@event, 
                    partial: 'events/event', 
                    locals: { event: @event }),
            turbo_stream.prepend('flash',
                    partial: 'layouts/flash', locals: { flash: flash })
          ]
          
        end

        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@event, 
                    partial: 'events/form', 
                    locals: { event: @event })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy

    respond_to do |format|
      
      format.html { redirect_to menu_index_url(
        ligue: @event.division.saison.ligue, 
        saison: @event.division.saison,
        division: @event.division),
        notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:circuit_id, :division_id, :horaire, :numero)
    end

    def authorize_admin_ligue
      unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

end
