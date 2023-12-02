class SyntheseLicencesController < ApplicationController
  def index
    if params[:event]
      @event = Event.find(params[:event]) 
      #@resultats = @event.resultats
      @division = Division.find(@event.division_id)

    end
  end

  def generate_image
    @event = Event.find(params[:event])
    render "synthese_licences/document"
  end

end
