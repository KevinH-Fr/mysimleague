class ClassementPilotesController < ApplicationController

  def generate_image
    @event = Event.find(params[:event])
    render "classement_pilotes/document"
  end

end
