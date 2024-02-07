class EventsController < ApplicationController

  include AssociationAdminsHelper

  before_action :set_event, only: %i[ show edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ new duplication create edit update destroy ]

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
            ), notice: I18n.t('notices.successfully_created') }
          
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
        flash.now[:success] = I18n.t('notices.successfully_updated')

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
        notice: I18n.t('notices.successfully_destroyed')}
      format.json { head :no_content }
    end
  end

  def duplication
    if request.post?
      source_division_id = params[:source_division]
      date_difference = params[:date_difference].to_i
  
      # Retrieve the source division and its events
      source_division = Division.find(source_division_id)
      source_events = source_division.events
  
      # Duplicate and adjust events
      source_events.each do |source_event|
        new_event = source_event.dup
        new_event.division_id = session[:division]
        new_event.horaire += date_difference.days
        new_event.save
      end
  
      flash[:notice] = "Events duplicated successfully."
    end
    redirect_to menu_index_path(ligue: session[:ligue], saison: session[:saison] , division: session[:division] ) # Redirect back to the events page or adjust as needed
  end
  
  def generate_image_stats_event

    @event = Event.find(params[:event])


    if @event 

      @paris = @event.paris 
      @nb_paris = @paris.count.to_i
      @sum_paris = @paris.sum(:montant).to_i

      won_paris = @paris.where(resultat: "true")

      if @nb_paris > 0
        @pari_with_biggest_solde = won_paris.order(solde: :desc).first  
        @pari_with_highest_cote = won_paris.order(cote: :desc).first
      end 

      @nb_dotds = @event.dotds.count

      if @nb_dotds > 0
        @association_user_with_most_votes = @event.dotds.joins(:association_user)
          .group('association_users.id, dotds.id')  # Include the necessary columns in the GROUP BY clause
          .order('COUNT(dotds.id) DESC')
          .first
      
          @nb_votes_association_user_dotd = @event.dotds.joins(:association_user)
          .where('association_users.id' => @association_user_with_most_votes)
          .count
          
      end 

      @dois = @event.dois

      @implique_id_counts = @dois.group_by(&:implique_id).transform_values(&:count)
      @most_common_implique_id = @implique_id_counts.max_by { |_, count| count }&.first

      @resultat_with_biggest_delta = @event.resultats.max_by { |resultat|
        (resultat.qualification.to_i - resultat.course.to_i)
      }
    
    
      
    end 
    
    render "events/document"

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
        redirect_to root_path, alert: "Tu n'es pas autorisé(e) à faire cette action"
      end
    end

end
