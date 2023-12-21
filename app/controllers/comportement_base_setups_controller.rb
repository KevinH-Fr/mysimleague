class ComportementBaseSetupsController < ApplicationController
  before_action :set_comportement_base_setup, only: %i[ show edit update destroy ]

  # GET /comportement_base_setups or /comportement_base_setups.json
  def index
    @comportement_base_setups = ComportementBaseSetup.all
  end

  # GET /comportement_base_setups/1 or /comportement_base_setups/1.json
  def show
  end

  # GET /comportement_base_setups/new
  def new
    @comportement_base_setup = ComportementBaseSetup.new
  end

  # GET /comportement_base_setups/1/edit
  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@comportement_base_setup, partial: 'comportement_base_setups/form', locals: { comportement_base_setup: @comportement_base_setup })
      end
    end
  end

  # POST /comportement_base_setups or /comportement_base_setups.json
  def create
    @comportement_base_setup = ComportementBaseSetup.new(comportement_base_setup_params)

    respond_to do |format|
      if @comportement_base_setup.save

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_comportement_base_setup', partial: 'comportement_base_setups/form', locals: { comportement_base_setup: ComportementBaseSetup.new }),
            turbo_stream.prepend('comportement_base_setups', partial: 'comportement_base_setups/comportement_base_setup', locals: { comportement_base_setup: @comportement_base_setup })
          ]
        end

          format.html { redirect_to comportement_base_setup_url(@comportement_base_setup), notice: "Comportement base setup was successfully created." }
          format.json { render :show, status: :created, location: @comportement_base_setup }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update('new_comportement_base_setup', partial: 'comportement_base_setups/form', locals: { comportement_base_setup: @comportement_base_setup})
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comportement_base_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comportement_base_setups/1 or /comportement_base_setups/1.json
  def update
    respond_to do |format|
      if @comportement_base_setup.update(comportement_base_setup_params)
  
        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@comportement_base_setup, partial: 'comportement_base_setups/comportement_base_setup', locals: { comportement_base_setup: @comportement_base_setup })
        end

        format.html { redirect_to comportement_base_setup_url(@comportement_base_setup), notice: "Comportement base setup was successfully updated." }
        format.json { render :show, status: :ok, location: @comportement_base_setup }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@comportement_base_setup, partial: 'comportement_base_setups/form', locals: { comportement_base_setup: @comportement_base_setup })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comportement_base_setup.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comportement_base_setups/1 or /comportement_base_setups/1.json
  def destroy
    @comportement_base_setup.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@comportement_base_setup) }
      format.html { redirect_to comportement_base_setups_url, notice: "Comportement base setup was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comportement_base_setup
      @comportement_base_setup = ComportementBaseSetup.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comportement_base_setup_params
      params.require(:comportement_base_setup).permit(:sens, :base_setup_id, :comportement_id, :comportement_base_setups)
    end
end
