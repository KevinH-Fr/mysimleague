class DivisionsController < ApplicationController
  include AssociationAdminsHelper

  before_action :set_division, only: %i[ edit update destroy ]
  before_action :authorize_admin_ligue, only: %i[ new create edit update destroy ]

  def new

    if params[:saison]
      @saison = Saison.find(params[:saison])
      @division = @saison.divisions.build
    else
      @division = Division.new
    end 

  end

  def edit
    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@division, 
          partial: "divisions/form", 
          locals: {division: @division})
      end
    end
  end

  def create
    @division = Division.new(division_params)

    respond_to do |format|
      if @division.save

        format.html { redirect_to menu_index_path(
          ligue: @division.saison.ligue, saison: @division.saison.id, division: @division.id
          ), notice: "Division was successfully created." }

        format.json { render :show, status: :created, location: @division }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@division, 
                    partial: 'divisions/form', 
                    locals: { division: @division })
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @division.update(division_params)

        # Ensure 'archived' is set to true when archiving
        @division.update(archived: true) if division_params[:archived] == 'true'

        flash.now[:success] = "division was successfully updated"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@division, 
                    partial: 'divisions/division', 
                    locals: { division: @division }),
            turbo_stream.prepend('flash',
                      partial: 'layouts/flash', locals: { flash: flash })
          ]
      
        end

        format.html { redirect_to division_url(@division), notice: "Division was successfully updated." }
        format.json { render :show, status: :ok, location: @division }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@division, 
                    partial: 'divisions/form', 
                    locals: { division: @division })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @division.destroy

    respond_to do |format|
      format.html { redirect_to menu_index_url(
        ligue: @division.saison.ligue, 
        saison: @division.saison ),
        notice: "Ligue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def authorize_admin_ligue
      unless current_user && verif_admin_ligue(current_user, session[:ligue]) 
        redirect_to root_path, alert: I18n.t('notices.unauthorized_action') 
      end
    end
  
    def set_division
      @division = Division.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def division_params
      params.require(:division).permit(:saison_id, :nom, :archived, :licence_equipe)
    end
end
