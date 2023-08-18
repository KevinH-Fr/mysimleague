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

    # reprendre : faire l'ajout de points recup 
    users_licences = cumul_licence_user(@event) # Call the helper method to get user licences and solde
    maximum_solde =  @event.division.saison.ligue.points_initial

    users_licences.each do |user_licence|
      user_id = user_licence[:user_id]
      solde = user_licence[:solde]
    
      if @event.numero >= 4 # Check if the event's numero is greater than or equal to 3
        previous_events = Event.where("numero <= ?", @event.numero)
                               .where("division_id = ?", @event.division_id)
                               .order(numero: :desc).limit(3)
        user_licences = Licence.joins(:event).where(association_user_id: user_id, events: { id: previous_events }).pluck(:penalite)
       
        user_licences = user_licences.map(&:to_i)
    
        if solde < maximum_solde
          if maximum_solde - solde > 2
            Licence.create(association_user_id: user_id, event_id: @event.id, gain: 2)
          else 
            Licence.create(association_user_id: user_id, event_id: @event.id, gain: 1)
          end
        end
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
