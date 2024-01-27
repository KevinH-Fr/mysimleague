class LicencesEquipesController < ApplicationController
  
    include EquipesHelper
    include AssociationAdminsHelper
    include SyntheseLicencesEquipeHelper

    before_action :set_licences_equipe, only: %i[ show edit update destroy ]
    before_action :authorize_admin_ligue, only: %i[ new show index create edit update destroy ]
  
    def update_licences_equipes

        @event = event_courant #from appli controller
        @dois = @event.dois
    
        #effacer existants avant creation
        LicencesEquipe.where(event_id: @event.id).destroy_all


        # creer licences avec pena depuis doi
        @dois.each do |doi|
            association_user = AssociationUser.find_by(id: doi.implique_id)
          
            if association_user.present?
              equipe = association_user.equipe
          
              if equipe.present?
                LicencesEquipe.create(
                    equipe_id: equipe.id,
                    event_id: @event.id,
                    perte: doi.penalite
                )

              end
            end
        end

        # creer licences avec gain recup point selon condition de l'helper synth licence
        calcul_recup_licence_equipe(@event).each do |equipe|
            if equipe[:recup_applicable] == true
                LicencesEquipe.create(equipe_id: equipe[:id], event_id: @event.id, gain: equipe[:nb_points_recup])
            end
        end
  
        redirect_to menu_index_path(
            ligue: @event.division.saison.ligue, 
            saison: @event.division.saison.id, 
            division: @event.division.id,
            event: @event.id
          )
      
        flash[:notice] = I18n.t('notices.successfully_updated')

          
    end
  
    def supprimer_licences_equipes
    end
  
    private
  
      def authorize_admin_ligue
        unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
          redirect_to root_path, alert: I18n.t('notices.unauthorized_action') 
        end
      end
  
      def set_licences_equipe
        @licences_equipe = LicencesEquipe.find(params[:id])
      end
  
      def licence_equipe_params
        params.require(:licences_equipe).permit(:event_id, :equipe_id, :gain, :perte)
      end
  end
  