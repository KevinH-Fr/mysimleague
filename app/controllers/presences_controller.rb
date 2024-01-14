class PresencesController < ApplicationController

  include AssociationUsersHelper
  include PresencesHelper

  before_action :set_presence, only: %i[ show edit update destroy ]
  before_action :authorize_user_ligue, only: %i[ new show create destroy ]
  before_action :authorize_edit_user, only: %i[ edit update destroy ]
  before_action :check_datetime_user_presence, only: %i[ new create edit update destroy]

  def edit
    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@presence, 
          partial: "presences/form", 
          locals: {presence: @presence})
      end
    end
  end

  def update
    respond_to do |format|
      if @presence.update(presence_params)

        format.turbo_stream do
          flash.now[:success] = I18n.t('notices.successfully_updated')

          render turbo_stream: [ 
            turbo_stream.update(@presence, 
                    partial: 'presences/presence', 
                    locals: { presence: @presence }),

          turbo_stream.update(
            'partial-presences-stats-container', partial: 'presences/stats'
            ),
          
            # Include a Turbo Stream command to display the flash notice
            turbo_stream.prepend('flash',
              partial: 'layouts/flash', locals: { flash: flash })
          ]
        end

        format.html { redirect_to presence_url(@presence), notice: "Association was successfully updated." }
        format.json { render :show, status: :ok, location: @presence }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@presence, 
                    partial: 'presences/form', 
                    locals: { presence: @presence })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @presence.errors, status: :unprocessable_entity }
      end
    end
  end

  def create

   @presence = Presence.new(presence_params)

    respond_to do |format|
      if @presence.save
        flash.now[:success] = I18n.t('notices.successfully_created')

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_presence',
              partial: "presences/form",
              locals: { presence: Presence.new }),

            turbo_stream.append('presences',
                                 partial: "presences/presence",
                                 locals: { presence: @presence }),

            turbo_stream.update(:content_new_presence, 
              partial: 'presences/new_presence'),          
            turbo_stream.update(
                'partial-presences-stats-container', partial: 'presences/stats'
                ),

            # Include a Turbo Stream command to display the flash notice
            turbo_stream.prepend('flash',
              partial: 'layouts/flash',
              locals: { flash: flash })
          ]
        end

        format.html { redirect_to presence_url(@presence), notice: "presence was successfully created." }
        format.json { render :show, status: :created, location: @presence }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @presence.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @presence.destroy
  
    respond_to do |format|
      flash.now[:success] = I18n.t('notices.successfully_destroyed')
      format.turbo_stream do

        render turbo_stream: [
          turbo_stream.remove(@presence),
          turbo_stream.update(:content_new_presence, 
            partial: 'presences/new_presence'),
  
          turbo_stream.update(
           'partial-presences-stats-container', partial: 'presences/stats'
          ),

          turbo_stream.prepend('flash',
            partial: 'layouts/flash',
            locals: { flash: flash })
        ]

      end
      format.html { redirect_to presences_url, notice: "Presence was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def authorize_user_ligue
      unless current_user && verif_appartenance_division(current_user, session[:division]) 
        redirect_to root_path, alert: I18n.t('notices.unauthorized_action') 
      end
    end

    def authorize_edit_user
      unless current_user && verif_propriete_presence(current_user, @presence.association_user_id) 
        redirect_to root_path, alert: I18n.t('notices.unauthorized_action') 
      end
    end

    def check_datetime_user_presence
      unless current_user && verif_delai_presence(Event.find(session[:event]).id)
        redirect_to root_path, alert:  I18n.t('notices.unauthorized_action') 
      end
    end

    def set_presence
      @presence = Presence.find(params[:id])
    end

    def presence_params
      params.require(:presence).permit(:event_id, :association_user_id, :status)
    end

end
