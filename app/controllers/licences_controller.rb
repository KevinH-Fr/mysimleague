class LicencesController < ApplicationController

  include AssociationUsersHelper
  include AssociationAdminsHelper
  include SyntheseLicencesHelper

  before_action :set_licence, only: %i[ show edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ new show index create edit update destroy ]

  def update_licences

    @event = event_courant #from appli controller
    @dois = @event.dois

    #effacer existants avant creation
    Licence.where(event_id: @event.id).destroy_all

    # creer licences avec pena depuis doi
    @dois.each do |doi|
      Licence.create(
        association_user_id: doi.implique_id, 
        event_id: @event.id, 
        perte: doi.penalite )
    end

    # creer licences avec gain recup point selon condition de l'helper synth licence
    calcul_recup_licence(@event).each do |pilote|
      if pilote[:recup_applicable] == true
        Licence.create(association_user_id: pilote[:id], event_id: @event.id, gain: pilote[:nb_points_recup])
        puts "________________create licence recup pour asso user: #{pilote[:id]}"
      end
    end


    redirect_to menu_index_path(
      ligue: @event.division.saison.ligue, 
      saison: @event.division.saison.id, 
      division: @event.division.id,
      event: @event.id,
      expand_synthese_licences: true # Add this line to pass the parameter
    )

  end

  def supprimer_licences 
    Licence.where(event_id: event_courant.id).destroy_all
    redirect_to menu_index_path(
      ligue: @event.division.saison.ligue, 
      saison: @event.division.saison.id, 
      division: @event.division.id,
      event: @event.id,
    )
  end

  private

    def authorize_admin_ligue
      unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

    def set_licence
      @licence = Licence.find(params[:id])
    end

    def licence_params
      params.require(:licence).permit(:event_id, :association_user_id, :gain, :perte)
    end
end
