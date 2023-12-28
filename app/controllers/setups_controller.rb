class SetupsController < ApplicationController

  include ScoreSetupHelper
  include SetupsHelper

  before_action :set_setup, only: %i[ show edit update destroy ]
  before_action :authorize_edit_user, only: %i[ show new edit update destroy ]


  def index
    @setups = Setup.where(user_id: current_user)
    @circuits = Circuit.all.order(:pays) 

  end

  def show
    @setup = Setup.find(params[:setup]) if params[:setup]
    session[:setup] = @setup.id if @setup  

    session[:score] = synthese_performance_data(@setup)   
    session[:score_details] = categorie_performances_with_details(Setup.find(session[:setup]))
 
    if session[:initial_score].present?
      @delta_data = compare_scores(session[:initial_score], session[:score])
    end

    data = []

  end

  def new
    @setup = Setup.new
    
  end

  def edit

    @circuits = Circuit.all.order(:pays) 

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@setup, partial: 'setups/form', locals: { setup: @setup })
      end
    end
  end

  def create
    @setup = Setup.new(setup_params)
    @circuits = Circuit.all.order(:pays) 

    respond_to do |format|
      if @setup.save

       # format.turbo_stream do
       #   render turbo_stream: [
       #     turbo_stream.update('new_setup', partial: 'setups/form', locals: { setup: Setup.new }),
       #     turbo_stream.prepend('setups', partial: 'setups/setup', locals: { setup: @setup })
       #   ]
       # end

        format.html { redirect_to setup_url(@setup), notice: "Setup was successfully created." }
        format.json { render :show, status: :created, location: @setup }
      else

       # format.turbo_stream do
       #   render turbo_stream: turbo_stream.update('new_setup', partial: 'setups/form', locals: { setup: @setup})
       # end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @setup.errors, status: :unprocessable_entity }
      end
    end
  end

  def update

  #  @score_details = categorie_performances_with_details(Setup.find(session[:setup]))

    respond_to do |format|
      if @setup.update(setup_params)


        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@setup, partial: 'setups/setup', locals: { setup: @setup })
        end

        format.html { redirect_to setup_url(@setup), notice: "Setup was successfully updated." }
        format.json { render :show, status: :ok, location: @setup }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@setup, partial: 'setups/form', locals: { setup: @setup })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @setup.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @setup.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@setup) }
      format.html { redirect_to setups_url, notice: "Setup was successfully destroyed." }
      format.json { head :no_content }
    end
  end


  def display_pb2

    @problem_id = params[:problem_id]

    @problems_secondaires = Problem.find(@problem_id).problem_seconds

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-pb2-container', partial: 'setups/pb_second'
        )
      end
    end
  end

  
  def display_correctif

    @problem_secondaire_id = params[:problem_secondaire_id]
    @correctifs = Correctif.where(problem_second_id: @problem_secondaire_id)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-correctifs-container', partial: 'setups/correctifs'
        )
      end
    end
  end

  def display_details_correctif

    @correctif = Correctif.find(params[:correctif_id])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-details-correctif-container', partial: 'setups/details_correctif'
        )
      end
    end
  end

  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setup
      @setup = Setup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def setup_params
      params.require(:setup).permit(:game_id, :user_id, :circuit_id, :nom, :commentaires)
    end

    def authorize_edit_user
      unless current_user && verif_user_setup(current_user, @setup.user_id) 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end

end
