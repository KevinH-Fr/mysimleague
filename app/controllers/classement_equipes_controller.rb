class ClassementEquipesController < ApplicationController
  
  include ClassementEquipesHelper
  include AssociationUsersHelper

  def generate_image
    @event = Event.find(params[:event])
    @previous_event = Event.where(division_id: @event.division_id, numero: @event.numero - 1).first if @event

    render "classement_equipes/document"
  end

  def animation
    @event = Event.find(params[:event])
    @previous_event = Event.where(division_id: @event.division_id, numero: @event.numero - 1).first if @event
      
    resultats = somme_equipe(@event)

    @resultats = resultats.map do |classement|
      equipe =  Equipe.find_by(id: classement[:equipe_id]) 
      comparison = compare_equipe_ranks(@previous_event, @event)[classement[:equipe_id]] if @previous_event 
      rank_precedent = comparison ? comparison[:delta_rank].to_i + classement[:rank].to_i : classement[:rank]

      {
        equipe_id: equipe.id,
        equipe_nom: equipe.nom,
        banniere_url: equipe.banniere.url,
        equipe_color: equipe.couleurs,
        score_precedent: comparison ? comparison[:previous_score] : classement[:score_sum],
        score: classement[:score_sum],
        rank_precedent: rank_precedent, # Calculate rank_precedent if comparison is not nil
        rank_courant: classement[:rank],
        delta_rank: rank_precedent.to_i - classement[:rank].to_i

      }
    end
    
  end

end
