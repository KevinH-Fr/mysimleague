class ResultatsController < ApplicationController
  before_action :set_resultat, only: %i[ show edit update destroy ]

  # GET /resultats or /resultats.json
  def index
    @resultats = Resultat.all
  end

  # GET /resultats/1 or /resultats/1.json
  def show
  end

  # GET /resultats/new
  def new
    @resultat = Resultat.new
  end

  # GET /resultats/1/edit
  def edit
  end

  # POST /resultats or /resultats.json
  def create
    @resultat = Resultat.new(resultat_params)

    respond_to do |format|
      if @resultat.save
        format.html { redirect_to resultat_url(@resultat), notice: "Resultat was successfully created." }
        format.json { render :show, status: :created, location: @resultat }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @resultat.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resultats/1 or /resultats/1.json
  def update
    respond_to do |format|
      if @resultat.update(resultat_params)
        format.html { redirect_to resultat_url(@resultat), notice: "Resultat was successfully updated." }
        format.json { render :show, status: :ok, location: @resultat }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @resultat.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resultats/1 or /resultats/1.json
  def destroy
    @resultat.destroy

    respond_to do |format|
      format.html { redirect_to resultats_url, notice: "Resultat was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resultat
      @resultat = Resultat.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def resultat_params
      params.require(:resultat).permit(:event_id, :pilote_id, :equipe_id, :qualification, :course, :dotd, :mt, :score, :dnf, :dns)
    end
end
