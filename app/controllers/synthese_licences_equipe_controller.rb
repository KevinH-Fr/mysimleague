class SyntheseLicencesEquipeController < ApplicationController
  def index
    if params[:event]
      @event = Event.find(params[:event]) 
      #@resultats = @event.resultats
      @division = Division.find(@event.division_id)
    end
  end

  def details
    @equipe = Equipe.find(params[:equipe])
    @event = Event.find(params[:event])
    @division = @event.division
    @events = @division.events.where('events.numero <= ?', @event.numero).includes(circuit: { drapeau_attachment: :blob }).order(:numero)
  end

  def generate_image
    @event = Event.find(params[:event])
    render "synthese_licences_equipe/document"
  end

end
