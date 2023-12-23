class BaseSetupsController < ApplicationController
  before_action :set_base_setup, only: %i[ show edit update destroy ]
  before_action :authorize_admin, only: %i[ new create edit update index destroy ]

  # GET /base_setups or /base_setups.json
  def index
    @base_setups = BaseSetup.all
    @game_id = params[:game] if params[:game]
  end

  # GET /base_setups/1 or /base_setups/1.json
  def show
  end

  # GET /base_setups/new
  def new
    @base_setup = BaseSetup.new
  end

  # GET /base_setups/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@base_setup, partial: 'base_setups/form', locals: { base_setup: @base_setup })
      end
    end
  end

  # POST /base_setups or /base_setups.json
  def create
    @base_setup = BaseSetup.new(base_setup_params)

    respond_to do |format|
      if @base_setup.save

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_base_setup', partial: 'base_setups/form', locals: { base_setup: BaseSetup.new }),
            turbo_stream.prepend('base_setups', partial: 'base_setups/base_setup', locals: { base_setup: @base_setup })
          ]

          format.html { redirect_to base_setup_url(@base_setup), notice: "Base setup was successfully created." }
          format.json { render :show, status: :created, location: @base_setup }
        end
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update('new_base_setup', partial: 'base_setups/form', locals: { base_setup: @base_setup})
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @base_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /base_setups/1 or /base_setups/1.json
  def update
    respond_to do |format|
      if @base_setup.update(base_setup_params)

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@base_setup, partial: 'base_setups/base_setup', locals: { base_setup: @base_setup })
        end

        format.html { redirect_to base_setup_url(@base_setup), notice: "Base setup was successfully updated." }
        format.json { render :show, status: :ok, location: @base_setup }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@base_setup, partial: 'base_setups/form', locals: { base_setup: @base_setup })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @base_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /base_setups/1 or /base_setups/1.json
  def destroy
    @base_setup.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@base_setup) }
      format.html { redirect_to base_setups_url, notice: "Base setup was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_base_setup
      @base_setup = BaseSetup.find(params[:id])
    end

    def authorize_admin
      unless current_user && current_user.admin 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
    
    # Only allow a list of trusted parameters through.
    def base_setup_params
      params.require(:base_setup).permit(:game_id, :categorie_parametre_id, :parametre, :explication, :val_min, :val_max)
    end
end
