class EventsController < ApplicationController
  before_action :set_event, only: %i[ show edit update destroy ]

  def index
    search_params = params.permit(:format, :page, q:[:numero_cont])
    @q = Event.ransack(search_params[:q])
    events = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @events = pagy_countless(events, items: 20)
  end

  def show
  end

  def new
    @event = Event.new(event_params)
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@event, partial: "events/form", 
          locals: {event: @event})
      end
    end
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.turbo_stream do
          flash.now[:notice] = "le event #{@event.numero} a bien été ajouté"
          render turbo_stream: [
            turbo_stream.update('new_event', partial: "events/form", locals: {event: Event.new}),
            turbo_stream.prepend("events", partial: "events/event",
              locals: {event: @event }), 
              turbo_stream.update("flash", partial: "layouts/flash"),     
            ]
        end
        format.html { redirect_to event_url(@event), notice: "event was successfully created." }
        format.json { render :show, status: :created, location: @event }

      else
        flash.now[:notice] = "erreur - le event n'a pas été ajouté"
        format.turbo_stream do
          render turbo_stream: [
             turbo_stream.update("flash", partial: "layouts/flashError"),
           ]
         end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }

      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.turbo_stream do  
          flash.now[:notice] = "le event #{@event.numero} a bien été modifié"
          render turbo_stream: [
            turbo_stream.update(@event, partial: "events/event", 
              locals: {event: @event}),
              turbo_stream.update("flash", partial: "layouts/flash")
           ]
        end

        format.html { redirect_to event_url(@event), notice: "event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@event, partial: "events/form", 
            locals: {event: @event})
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@event) }
      format.html { redirect_to events_url, notice: "event was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:date, :horaire, :numero, :circuit_id, :saison_id, :division_id, :ligue_id)
    end
end
