class SaisonsController < ApplicationController
  before_action :set_saison, only: %i[ show edit update destroy ]

  def index
    @saisons = Saison.all

    @ligues = Ligue.all
    @ligueId = params[:ligueId]

    if @ligueId.present?
      @ligue = Ligue.find(params[:ligueId]) 
      @saisons = @ligue.saisons
    end

  end

  def show
  end

  def new
    @saison = Saison.new(saison_params)
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@saison, partial: "saisons/form", 
          locals: {saison: @saison})
      end
    end
  end

  def create
    @saison = Saison.new(saison_params)

    respond_to do |format|
      if @saison.save
        format.turbo_stream do
          flash.now[:notice] = "le saison #{@saison.nom} a bien été ajouté"
          render turbo_stream: [
            turbo_stream.update('new_saison', partial: "saisons/form", locals: {saison: Saison.new}),
            turbo_stream.prepend("saisons", partial: "saisons/saison",
              locals: {saison: @saison }), 
              turbo_stream.update("flash", partial: "layouts/flash"),     
            ]
        end
        format.html { redirect_to saison_url(@saison), notice: "saison was successfully created." }
        format.json { render :show, status: :created, location: @saison }

      else
        flash.now[:notice] = "erreur - le saison n'a pas été ajouté"
        format.turbo_stream do
          render turbo_stream: [
             turbo_stream.update("flash", partial: "layouts/flashError"),
           ]
         end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @saison.errors, status: :unprocessable_entity }

      end
    end
  end

  def update
    respond_to do |format|
      if @saison.update(saison_params)
        format.turbo_stream do  
          flash.now[:notice] = "le saison #{@saison.nom} a bien été modifié"
          render turbo_stream: [
            turbo_stream.update(@saison, partial: "saisons/saison", 
              locals: {saison: @saison}),
              turbo_stream.update("flash", partial: "layouts/flash")
           ]
        end

        format.html { redirect_to saison_url(@saison), notice: "saison was successfully updated." }
        format.json { render :show, status: :ok, location: @saison }
      else
        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@saison, partial: "saisons/form", 
            locals: {saison: @saison})
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @saison.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @saison.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@saison) }
      format.html { redirect_to saisons_url, notice: "Saison was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_saison
      @saison = Saison.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def saison_params
      params.require(:saison).permit(:nom, :numero, :ligue_id)
    end
end
