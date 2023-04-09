class CircuitsController < ApplicationController
  before_action :set_circuit, only: %i[ show edit update destroy ]

  def index
    search_params = params.permit(:format, :page, q:[:nom_cont])
    @q = Circuit.ransack(search_params[:q])
    circuits = @q.result(distinct: true).order(created_at: :desc)
    @pagy, @circuits = pagy_countless(circuits, items: 20)
  end

  def show
  end

  def new
    @circuit = Circuit.new(circuit_params)
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@circuit, partial: "circuits/form", 
          locals: {circuit: @circuit})
      end
    end
  end

  def create
    @circuit = Circuit.new(circuit_params)

    respond_to do |format|
      if @circuit.save
        format.turbo_stream do
          flash.now[:notice] = "le circuit #{@circuit.nom} a bien été ajouté"
          render turbo_stream: [
            turbo_stream.update('new_circuit', partial: "circuits/form", locals: {circuit: Circuit.new}),
            turbo_stream.prepend("circuits", partial: "circuits/circuit",
              locals: {circuit: @circuit }), 
              turbo_stream.update("flash", partial: "layouts/flash"),     
            ]
        end
        format.html { redirect_to circuit_url(@circuit), notice: "circuit was successfully created." }
        format.json { render :show, status: :created, location: @circuit }

      else
        flash.now[:notice] = "erreur - le circuit n'a pas été ajouté"
        format.turbo_stream do
          render turbo_stream: [
             turbo_stream.update("flash", partial: "layouts/flashError"),
           ]
         end
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @circuit.errors, status: :unprocessable_entity }

      end
    end
  end

  def update
    respond_to do |format|
      if @circuit.update(circuit_params)
        format.turbo_stream do  
          flash.now[:notice] = "le circuit #{@circuit.nom} a bien été modifié"
          render turbo_stream: [
            turbo_stream.update(@circuit, partial: "circuits/circuit", 
              locals: {circuit: @circuit}),
              turbo_stream.update("flash", partial: "layouts/flash")
           ]
        end

        format.html { redirect_to circuit_url(@circuit), notice: "circuit was successfully updated." }
        format.json { render :show, status: :ok, location: @circuit }
      else
        format.turbo_stream do  
          render turbo_stream: turbo_stream.update(@circuit, partial: "circuits/form", 
            locals: {circuit: @circuit})
        end
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @circuit.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @circuit.destroy

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@circuit) }
      format.html { redirect_to circuits_url, notice: "Circuit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_circuit
      @circuit = Circuit.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def circuit_params
      params.require(:circuit).permit(:nom, :pays, :adresse, :latitude, :longitude)
    end
end
