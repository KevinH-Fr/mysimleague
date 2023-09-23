class ClassementPilotesController < ApplicationController

  include ClassementPilotesHelper
  include AssociationUsersHelper

  def generate_image
    @event = Event.find(params[:event])
    @previous_event = Event.where(division_id: @event.division_id, numero: @event.numero - 1).first if @event

    render "classement_pilotes/document"
  end

  def animation
    @event = Event.find(params[:event])
    @previous_event = Event.where(division_id: @event.division_id, numero: @event.numero - 1).first if @event
      
    resultats = somme_user(@event)

    @resultats = resultats.map do |classement|
      association_user = AssociationUser.find_by(id: classement[:association_user_id])
      comparison = compare_ranks(@previous_event, @event)[association_user[:user_id]] if @previous_event 
   

      {
        equipe_id: association_user.equipe_id,
       # banniere_url: association_user.equipe.banniere.url,
        equipe_color: association_user.equipe.couleurs,
        pilote: association_user.user.nom,
        score_precedent:  comparison ? comparison[:previous_score] : classement[:score],
        score: classement[:score],
        rank_precedent: comparison ? comparison[:delta_rank].to_i + classement[:rank].to_i : classement[:rank], # Calculate rank_precedent if comparison is not nil
        rank_courant: classement[:rank]
      }
    end
    
  end

end
