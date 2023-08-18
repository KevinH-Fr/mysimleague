class SaisonsController < ApplicationController
  include AssociationAdminsHelper

  before_action :set_saison, only: %i[ edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ new create edit update destroy ]

  def new
    @ligue = Ligue.find(params[:ligue])
    @saison = @ligue.saisons.build

  end

  def edit
    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@saison, 
          partial: "saisons/form", 
          locals: {saison: @saison})
      end
    end
  end

  def create
    @saison = Saison.new(saison_params)
    @ligue = Ligue.find(params[:ligue]) if params[:ligue]

    respond_to do |format|
      if @saison.save

        format.html { redirect_to menu_index_path(ligue: @saison.ligue, saison: @saison.id), notice: "Saison was successfully created." }
        format.json { render :show, status: :created, location: @saison }
      else

        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace(
            'new_saison', partial: 'saisons/form', locals: { saison: @saison}
        ) }

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @saison.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @saison.update(saison_params)
        flash.now[:success] = "saison was successfully updated"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@saison, 
                    partial: 'saisons/saison', 
                    locals: { saison: @saison }),
            turbo_stream.prepend('flash',
                      partial: 'layouts/flash', locals: { flash: flash })
          ]
        end

        format.html { redirect_to saison_url(@saison), notice: "Saison was successfully updated." }
        format.json { render :show, status: :ok, location: @saison }
      else

        
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@saison, 
                    partial: 'saisons/form', 
                    locals: { saison: @saison })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @saison.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @saison.destroy

    respond_to do |format|
      format.html { redirect_to menu_index_url(ligue: @saison.ligue_id), notice: "saison was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def authorize_admin_ligue
      unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
    
    def set_saison
      @saison = Saison.find(params[:id])
    end

    def saison_params
      params.require(:saison).permit(:ligue_id, :nom)
    end
end
