class ReglementsController < ApplicationController

  include AssociationAdminsHelper

  before_action :set_reglement, only: %i[ show edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ index new create edit update destroy ]

  def index
    @reglements = Reglement.all
  end

  def show
    @reglement = Reglement.find(params[:id])

    respond_to do |format|
      format.html # This will render the default HTML view for the show action (show.html.erb)
      format.json { render json: { 
        reglement_id: @reglement.id, 
        penalite_points: @reglement.penalite,
        penalite_temps: @reglement.penalite_temps,
        contenu_article: @reglement.contenu_article
      } } # This will respond with JSON data
    end
  end

  def new
    @reglement = Reglement.new
  end

  def edit
    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@reglement, 
          partial: "reglements/form", 
          locals: {reglement: @reglement})
      end
    end
  end

  def create

    @ligue = Ligue.find(session[:ligue]) if session[:ligue]

    @reglement = Reglement.new(reglement_params)

    respond_to do |format|
      if @reglement.save
        flash.now[:success] = "reglement was successfully created"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_reglement',
                               partial: "reglements/form",
                               locals: { reglement: Reglement.new }),
  
            turbo_stream.append('reglements',
                                 partial: "reglements/reglement",
                                 locals: { reglement: @reglement }),

            turbo_stream.prepend('flash', partial: 'layouts/flash', locals: { flash: flash })
          ]
        end

        format.html { redirect_to reglement_url(@reglement), notice: "Reglement was successfully created." }
        format.json { render :show, status: :created, location: @reglement }
      else
        format.turbo_stream do
          render turbo_stream.update(
            'new_reglement',
            partial: "reglements/form",
            locals: { reglement: @reglement }
          )
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @reglement.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reglement.update(reglement_params)
        flash.now[:success] = "reglement was successfully updated"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@reglement, 
                    partial: 'reglements/reglement', 
                    locals: { reglement: @reglement }),

            turbo_stream.prepend('flash', partial: 'layouts/flash', locals: { flash: flash })
          ]        
        end

        format.html { redirect_to reglement_url(@reglement), notice: "Reglement was successfully updated." }
        format.json { render :show, status: :ok, location: @reglement }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@reglement, 
                    partial: 'reglements/form', 
                    locals: { reglement: @reglement })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @reglement.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @reglement.destroy

    respond_to do |format|

      format.turbo_stream do
        render turbo_stream: turbo_stream.remove(@reglement)
      end

      format.html { redirect_to reglements_url, notice: "Reglement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def authorize_admin_ligue
    unless current_user && (verif_admin_ligue(current_user, session[:ligue]) || current_user.admin?)
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
  

  def set_reglement
    @reglement = Reglement.find(params[:id])
  end

  def reglement_params
    params.require(:reglement).permit(:ligue_id, :num_article, :titre_article, :contenu_article, :penalite, :penalite_temps, :defaut)
  end
  
end
