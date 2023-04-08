class LiguesController < ApplicationController
  before_action :set_ligue, only: %i[ show edit update destroy ]

  # GET /ligues or /ligues.json
  def index
    @ligues = Ligue.all
  end

  # GET /ligues/1 or /ligues/1.json
  def show
  end

  # GET /ligues/new
  def new
    @ligue = Ligue.new
  end

  # GET /ligues/1/edit
  def edit
  end

  # POST /ligues or /ligues.json
  def create
    @ligue = Ligue.new(ligue_params)

    respond_to do |format|
      if @ligue.save
        format.html { redirect_to ligue_url(@ligue), notice: "Ligue was successfully created." }
        format.json { render :show, status: :created, location: @ligue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ligue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ligues/1 or /ligues/1.json
  def update
    respond_to do |format|
      if @ligue.update(ligue_params)
        format.html { redirect_to ligue_url(@ligue), notice: "Ligue was successfully updated." }
        format.json { render :show, status: :ok, location: @ligue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ligue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ligues/1 or /ligues/1.json
  def destroy
    @ligue.destroy

    respond_to do |format|
      format.html { redirect_to ligues_url, notice: "Ligue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ligue
      @ligue = Ligue.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ligue_params
      params.require(:ligue).permit(:nom, :description)
    end
end
