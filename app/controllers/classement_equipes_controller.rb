class ClassementEquipesController < ApplicationController

  def generate_image
    @event = Event.find(params[:event])
    @previous_event = Event.where(division_id: @event.division_id, numero: @event.numero - 1).first if @event

    render "classement_equipes/document"
  end
end
