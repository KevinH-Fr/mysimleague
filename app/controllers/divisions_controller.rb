class DivisionsController < ApplicationController
  before_action :set_division, only: %i[ show edit update destroy ]

  def index
    @divisions = Division.all

    @ligues = Ligue.all
    @ligueId = params[:ligueId]
    @saisonId = params[:saisonId]

    @saisons = Saison.ligue_courante(@ligueId)
    @divisions = Division.saison_courante(@saisonId)

  end

  def show
  end

  def new
    @division = Division.new(division_params)
  end

  def edit

    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@division, partial: "divisions/form", 
          locals: {division: @division})
      end
    end
  end

  def create
    @division = Division.new(division_params)

    respond_to do |format|
      if @division.save
        format.turbo_stream do
          flash.now[:notice] = "le division #{@division.nom} a bien été ajouté"
          render turbo_stream: [
            turbo_stream.update('new_division', partial: "divisions/form", locals: {division: Division.new}),
            turbo_stream.prepend("divisions", partial: "divisions/division",
              locals: {division: @division }), 
              turbo_stream.update("flash", partial: "layouts/flash"),     
            ]
        end
        format.html { redirect_to division_url(@saison), notice: "division was successfully created." }
        format.json { render :show, status: :created, location: @division }

      else
        flash.now[:notice] = "erreur - le division n'a pas été ajouté"
        format.turbo_stream do
          render turbo_stream: [
             turbo_stream.update("flash", partial: "layouts/flashError"),
           ]
         end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @division.errors, status: :unprocessable_entity }

      end
    end
  end

  def update

    respond_to do |format|
      if @division.update(division_params)
        format.turbo_stream do  
          flash.now[:notice] = "le division #{@division.nom} a bien été modifié"
          render turbo_stream: [
            turbo_stream.update(@division, partial: "divisions/division", 
              locals: {division: @division}),
              turbo_stream.update("flash", partial: "layouts/flash")
           ]
        end

        format.html { redirect_to division_url(@division), notice: "division was successfully updated." }
        format.json { render :show, status: :ok, location: @division }
      else
        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@division, partial: "divisions/form", 
            locals: {division: @division})
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @division.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @division.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@division) }
      format.html { redirect_to divisions_url, notice: "division was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_division
      @division = Division.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def division_params
      params.require(:division).permit(:nom, :numero, :saison_id)
    end
end
