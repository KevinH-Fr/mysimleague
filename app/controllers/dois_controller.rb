class DoisController < ApplicationController

  include AssociationUsersHelper
  include AssociationAdminsHelper
  include DoisHelper
  include ScoringHelper
  include UsersHelper


  before_action :set_doi, only: %i[ show edit update destroy ]
  before_action :authorize_user_ligue, only: %i[ new show create destroy ]
  before_action :user_connected_doi_ouvert, only: %i[ new create edit update destroy ]
 
  def new 
    @doi = Doi.new doi_params
    @event = Event.find(params[:event]) if params[:event]
    session[:event] = @event.id if @event
    @division = Division.find(@event.division_id) if @event
    session[:division] = @division.id if @division

  end

  def edit
    @event = Event.find(@doi.event_id)
    @division = Division.find(@event.division_id)

    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@doi, 
          partial: "dois/form", 
          locals: {doi: @doi})
      end
    end
  end

  def create

    @doi = Doi.new(doi_params)

    respond_to do |format|
      if @doi.save

        #call maj score pilote 
        @user = AssociationUser.find(@doi.implique_id).user
        @user.update(score_pilote: scoring_pilote_sum( @user))

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_doi',
                                partial: "dois/form",
                                locals: { doi: Doi.new }),
  
            turbo_stream.append('dois',
                                 partial: "dois/doi",
                                 locals: { doi: @doi })
          ]
        end

        format.html { redirect_to doi_url(@doi), notice: I18n.t('notices.successfully_created') }
        format.json { render :show, status: :created, location: @doi }
      else

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @doi.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

    respond_to do |format|
      if @doi.update(doi_params)

        #call maj score pilote 
        @user = AssociationUser.find(@doi.implique_id).user
        @user.update(score_pilote: scoring_pilote_sum( @user))

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@doi, 
                    partial: 'dois/doi', 
                    locals: { doi: @doi })
        end

        format.html { redirect_to doi_url(@doi), notice: I18n.t('notices.successfully_edited') }
        format.json { render :show, status: :ok, location: @doi }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@doi, 
                    partial: 'dois/form', 
                    locals: { doi: @doi })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @doi.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doi.destroy

    #call maj score pilote 
    @user = AssociationUser.find(@doi.implique_id).user
    @user.update(score_pilote: scoring_pilote_sum( @user))

    respond_to do |format|

      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@doi)
      end

      format.html { redirect_to dois_url, notice: I18n.t('notices.successfully_destroyed')}
      format.json { head :no_content }
    end
  end

  def generate_image
    @doi = Doi.find(params[:doi])
    @event = Event.find(@doi.event_id)
    render "dois/document"

  end

  private

    def authorize_user_ligue
      if verif_admin_ligue(current_user, session[:ligue])
        # If the user is an admin ligue, authorize the action
        # Add your authorization logic for admin ligue here
      else
        # If not an admin ligue, check division membership
        unless current_user && verif_appartenance_division(current_user, session[:division]) 
          redirect_to root_path, alert: I18n.t('notices.unauthorized_action') 
        end
      end
    end
  

    def user_connected_doi_ouvert
      unless verif_admin_ligue(current_user, session[:ligue]) || verif_delai_doi(session[:event])        
          redirect_to root_path, alert: I18n.t('notices.unauthorized_action') 
      end
    end
    
    def set_doi
      @doi = Doi.find(params[:id])
    end

    def doi_params
      params.fetch(:doi, {}).permit(:demandeur_id, :implique_id, :event_id, :description, :lien, :decision, :reglement_id, 
        :penalite, :penalite_temps, :commentaire, :association_admin_id, :doicommissaire)
    end
end
