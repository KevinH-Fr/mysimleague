class ParisController < ApplicationController

  include AssociationUsersHelper
  include ClassementPilotesHelper
  include CotesHelper
  include ParieursHelper
  include ParisHelper

  before_action :set_pari, only: %i[ show edit update destroy ]
  before_action :user_connected_pari_ouvert, only: %i[ new create edit update destroy ]
 # before_action :authorize_edit_user, only: %i[ edit update destroy ]
  before_action :user_not_in_division, only: %i[ new create ]

  def new
    @pari = Pari.new(pari_params)
    @event = Event.find(params[:event]) 
    session[:event] = @event.id  

  end

  def edit

      respond_to do |format|
        format.html
        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@pari, partial: "paris/form", 
            locals: {pari: @pari})
        end
      end

  end

  def create
    @pari = Pari.new(pari_params)

      respond_to do |format|
        if @pari.save
          flash.now[:success] = "pari was successfully created"

          format.turbo_stream do
            render turbo_stream: [
              turbo_stream.update('new_pari',
                partial: "paris/form",
                locals: { pari: Pari.new }),

              turbo_stream.append('paris',
                                   partial: "paris/pari",
                                   locals: { pari: @pari }),
              
              turbo_stream.prepend('flash',
                                    partial: 'layouts/flash', locals: { flash: flash })
            ]
          end

          format.html { redirect_to pari_url(@pari), notice: "Pari was successfully created." }
          format.json { render :show, status: :created, location: @pari }
        else

          format.turbo_stream do
            render turbo_stream: turbo_stream.update(@pari, 
                      partial: 'paris/form', 
                      locals: { pari: @pari })
          end

          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @pari.errors, status: :unprocessable_entity }
        end
      end

  end

  def update

      respond_to do |format|
        if @pari.update(pari_params)

          format.turbo_stream do
            render turbo_stream: turbo_stream.update(@pari, partial: 'paris/pari', locals: { pari: @pari })
          end

          format.html { redirect_to pari_url(@pari), notice: "Pari was successfully updated." }
          format.json { render :show, status: :ok, location: @pari }
        else

          format.turbo_stream do
            render turbo_stream: turbo_stream.update(@pari, partial: 'paris/form', locals: { pari: @pari })
          end

          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @pari.errors, status: :unprocessable_entity }
        end
      end

  end

  def destroy
    @pari.destroy

    respond_to do |format|
      format.html { redirect_to paris_url, notice: "Pari was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def user_connected_pari_ouvert
      unless current_user && verif_delai_pari(Event.find(session[:event]).id)
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

    def authorize_edit_user
      unless current_user && verif_user_pari(current_user, @pari.user_id) 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

    def user_not_in_division
      if verif_appartenance_division(current_user, Event.find(session[:event]).division_id)
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
    
    def set_pari
      @pari = Pari.find(params[:id])
    end

    def pari_params
      params.fetch(:pari, {}).permit(:event_id, :user_id, :association_user_id, :montant, :typepari, :cote, :resultat, :solde)
    end
end
