class SyntheseLicencesController < ApplicationController
  def index
    if params[:event]
      @event = Event.find(params[:event]) 
      #@resultats = @event.resultats
      @division = Division.find(@event.division_id)

    end
  end

  def details
    @user = User.find(params[:user])
    @event = Event.find(params[:event])
    @division = @event.division
    @events = @division.events.where('events.numero <= ?', @event.numero).includes(circuit: { drapeau_attachment: :blob }).order(:numero)

  end

  def generate_image
    @event = Event.find(params[:event])
    render "synthese_licences/document"
  end

end
