class ParametreSetupsController < ApplicationController

  include ScoreSetupHelper
  include SetupsHelper

  before_action :set_parametre_setup, only: %i[ show edit update destroy create_setups_initial_scores ]
  before_action :authorize_edit_user, only: %i[ show new create edit update destroy ]
  
  def index
    @parametre_setups = ParametreSetup.all
  end

  def show
  end

  # GET /parametre_setups/new
  def new
    @parametre_setup = ParametreSetup.new
  end

  # GET /parametre_setups/1/edit
  def edit
    session[:setup] = @parametre_setup.setup

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@parametre_setup, partial: 'parametre_setups/form', locals: { parametre_setup: @parametre_setup })
      end
    end
  end

  # POST /parametre_setups or /parametre_setups.json
  def create
    @parametre_setup = ParametreSetup.new(parametre_setup_params)

    respond_to do |format|
      if @parametre_setup.save

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append('parametre_setups', partial: 'parametre_setups/parametre_setup', locals: { parametre_setup: @parametre_setup }),
          #  turbo_stream.update('parametre_setups', partial: 'parametre_setups/parametre_setups'),
            turbo_stream.remove('new_parametre_setup'),

            turbo_stream.update(
              @parametre_setup, 
              partial: 'parametre_setups/parametre_setup', 
              locals: { parametre_setup: @parametre_setup }
            ),

            turbo_stream.update('score', 
              partial: 'setups/score'
            )   
          ]
        end 

        format.html { redirect_to parametre_setup_url(@parametre_setup), notice: "Parametre setup was successfully created." }
        format.json { render :show, status: :created, location: @parametre_setup }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update('new_parametre_setup', partial: 'parametre_setups/form', locals: { parametre_setup: @parametre_setup})
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @parametre_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parametre_setups/1 or /parametre_setups/1.json
  def update

    session[:setup] = @parametre_setup.setup.id
    @setup =  @parametre_setup.setup

    create_setups_initial_scores
    
    respond_to do |format|
      if @parametre_setup.update(parametre_setup_params.merge(filled: true))
        
        @delta_data = compare_scores(initial_score_json, synthese_performance_data(Setup.find(session[:setup])))
 
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(
              @parametre_setup, 
              partial: 'parametre_setups/parametre_setup', 
              locals: { parametre_setup: @parametre_setup }
            ),
            

            turbo_stream.update('score', 
              partial: 'setups/score'
            ),   

          ]
         
        end

        format.html { redirect_to parametre_setup_url(@parametre_setup), notice: "Parametre setup was successfully updated." }
        format.json { render :show, status: :ok, location: @parametre_setup }
      else

        format.turbo_stream do 
          render turbo_stream: turbo_stream.update(@parametre_setup,
                                                   partial: "parametre_setups/form",
                                                   locals: {parametre_setup: @parametre_setup})
        end
        
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @parametre_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parametre_setups/1 or /parametre_setups/1.json
  def destroy
    @parametre_setup.destroy!

    respond_to do |format|
      format.turbo_stream do 
        render turbo_stream: [
          turbo_stream.remove(@parametre_setup),
          turbo_stream.update('score', 
            partial: 'setups/score'
          )   
        ]
      end
      
      format.html { redirect_to parametre_setups_url, notice: "Parametre setup was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parametre_setup
      @parametre_setup = ParametreSetup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def parametre_setup_params
      params.require(:parametre_setup).permit(:setup_id, :base_setup_id, :val_parametre, :filled)
    end

    def authorize_edit_user
      unless current_user && verif_user_setup(current_user, @parametre_setup.setup.user_id) 
        redirect_to root_path, alert: I18n.t('notices.unauthorized_action') 
      end
    end


    def create_setups_initial_scores

      SetupsInitialScore.where(setup_id: @setup.id).destroy_all

      # Use your helper method to get comportements and details
      comportements_and_details = categorie_performances_with_details(@setup)
  
      # Create a record for each comportement
      comportements_and_details.each do |comportement_details|
        SetupsInitialScore.create(
          setup_id: @setup.id,
          comportement: Comportement.find_by(label_categorie: comportement_details[:category]),
          initial_score: comportement_details[:average_score]
        )
      end
    end
    
end
