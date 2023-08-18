class ClassementEquipesController < ApplicationController

  def generate_image
    @event = Event.find(params[:event])
    render "classement_equipes/document"
  end
end
