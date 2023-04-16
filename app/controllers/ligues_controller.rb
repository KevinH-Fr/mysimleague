class LiguesController < ApplicationController
  before_action :set_ligue, only: %i[ show edit update destroy ]

  def index
    search_params = params.permit(:format, :page, q:[:nom_cont])
    @q = Ligue.ransack(search_params[:q])
    ligues = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @ligues = pagy_countless(ligues, items: 20)

  end

  def show
    @saisons = @ligue.saisons
    @divisions = @ligue.divisions
  end

  def new
    @ligue = Ligue.new(ligue_params)
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@ligue, partial: "ligues/form", 
          locals: {ligue: @ligue})
      end
    end
  end

  def create
    @ligue = Ligue.new(ligue_params)

    respond_to do |format|
      if @ligue.save
        format.turbo_stream do
          flash.now[:notice] = "la ligue #{@ligue.nom} a bien été ajoutée"
          render turbo_stream: [
            turbo_stream.update('new_ligue', partial: "ligues/form", locals: {ligue: Ligue.new}),
            turbo_stream.prepend("ligues", partial: "ligues/ligue",
              locals: {ligue: @ligue }), 
              turbo_stream.update("flash", partial: "layouts/flash"),     
            ]
        end
        format.html { redirect_to ligue_url(@ligue), notice: "ligue was successfully created." }
        format.json { render :show, status: :created, location: @ligue }

      else
        flash.now[:notice] = "erreur - le ligue n'a pas été ajouté"
        format.turbo_stream do
          render turbo_stream: [
             turbo_stream.update("flash", partial: "layouts/flashError"),
           ]
         end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ligue.errors, status: :unprocessable_entity }

      end
    end
  end

  def update
    respond_to do |format|
      if @ligue.update(ligue_params)
        format.turbo_stream do  
          render turbo_stream: 
            turbo_stream.update(@ligue, partial: "ligues/ligue", 
              locals: {ligue: @ligue})
        end
        format.html { redirect_to ligue_url(@ligue), notice: "Ligue was successfully updated." }
        format.json { render :show, status: :ok, location: @ligue }
      else
        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@ligue, partial: "ligues/form", 
            locals: {ligue: @ligue})
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ligue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ligue.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@ligue) }
      format.html { redirect_to ligues_url, notice: "Ligue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_ligue
      @ligue = Ligue.find(params[:id])
    end

    def ligue_params
      params.require(:ligue).permit(:nom, :description, :icon)
    end
end
