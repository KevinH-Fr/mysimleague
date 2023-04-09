class EquipesController < ApplicationController
  before_action :set_equipe, only: %i[ show edit update destroy ]

  def index
    search_params = params.permit(:format, :page, q:[:nom_cont])
    @q = Equipe.ransack(search_params[:q])
    equipes = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @equipes = pagy_countless(equipes, items: 20)
  end

  def show
  end

  def new
    @equipe = Equipe.new(equipe_params)
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@equipe, partial: "equipes/form", 
          locals: {equipe: @equipe})
      end
    end
  end

  def create
    @equipe = Equipe.new(equipe_params)

    respond_to do |format|
      if @equipe.save
        format.turbo_stream do
          flash.now[:notice] = "le equipe #{@equipe.nom} a bien été ajouté"
          render turbo_stream: [
            turbo_stream.update('new_equipe', partial: "equipes/form", locals: {equipe: Equipe.new}),
            turbo_stream.prepend("equipes", partial: "equipes/equipe",
              locals: {equipe: @equipe }), 
              turbo_stream.update("flash", partial: "layouts/flash"),     
            ]
        end
        format.html { redirect_to equipe_url(@equipe), notice: "equipe was successfully created." }
        format.json { render :show, status: :created, location: @equipe }

      else
        flash.now[:notice] = "erreur - le equipe n'a pas été ajouté"
        format.turbo_stream do
          render turbo_stream: [
             turbo_stream.update("flash", partial: "layouts/flashError"),
           ]
         end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @equipe.errors, status: :unprocessable_entity }

      end
    end
  end

  def update
    respond_to do |format|
      if @equipe.update(equipe_params)
        format.turbo_stream do  
          flash.now[:notice] = "le equipe #{@equipe.nom} a bien été modifié"
          render turbo_stream: [
            turbo_stream.update(@equipe, partial: "equipes/equipe", 
              locals: {equipe: @equipe}),
              turbo_stream.update("flash", partial: "layouts/flash")
           ]
        end

        format.html { redirect_to equipe_url(@equipe), notice: "equipe was successfully updated." }
        format.json { render :show, status: :ok, location: @equipe }
      else
        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@equipe, partial: "equipes/form", 
            locals: {equipe: @equipe})
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @equipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @equipe.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@equipe) }
      format.html { redirect_to equipes_url, notice: "equipe was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_equipe
      @equipe = Equipe.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def equipe_params
      params.require(:equipe).permit(:nom, :couleur)
    end
end
