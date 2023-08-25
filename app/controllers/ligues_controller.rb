class LiguesController < ApplicationController
  include AssociationAdminsHelper

  before_action :set_ligue, only: %i[ edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ edit update destroy ]

  def new
    @ligue = Ligue.order(created_at: :desc)
  end

  def edit
    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@ligue, 
          partial: "ligues/form", 
          locals: {ligue: @ligue})
      end
    end
  end

  def create
    @ligue = Ligue.new(ligue_params)

    respond_to do |format|
      if @ligue.save    
        format.html { redirect_to menu_index_path(ligue: @ligue.id), notice: "Ligue was successfully created."  }
      else
        format.turbo_stream { 
          render turbo_stream: turbo_stream.replace(
            'new_ligue', partial: 'ligues/form', locals: { ligue: @ligue }
        ) }

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ligue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @ligue.update(ligue_params)
        flash.now[:success] = "ligue was successfully updated"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@ligue, 
                    partial: 'ligues/ligue', 
                    locals: { ligue: @ligue }),
            turbo_stream.prepend('flash',
                    partial: 'layouts/flash', locals: { flash: flash })
          ]
        end

        format.html { redirect_to ligue_url(@ligue), notice: "Ligue was successfully updated." }
        format.json { render :show, status: :ok, location: @ligue }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@ligue, 
                    partial: 'ligues/form', 
                    locals: { ligue: @ligue })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ligue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ligue.destroy

    respond_to do |format|
      format.html { redirect_to menu_index_url, notice: "Ligue was successfully destroyed." }
      format.json { head :no_content }
    end
  end 

  private    

    def authorize_admin_ligue
      unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
    
    def set_ligue
      @ligue = Ligue.find(params[:id])
    end

    def ligue_params
      params.require(:ligue).permit(:nom, :user_id, :points_initial, :reglement_defaut, :logo)
    end
end
