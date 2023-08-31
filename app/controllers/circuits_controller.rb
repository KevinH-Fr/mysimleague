class CircuitsController < ApplicationController

  before_action :set_circuit, only: %i[ show edit update destroy ]
  before_action :authorize_admin, only: %i[ new create edit update destroy ]

  def index
    @circuits = Circuit.order(created_at: :desc)
  end

  def show
  end

  def new
    @circuit = Circuit.new
  end

  def edit

    respond_to do |format|
      format.turbo_stream do  
        render turbo_stream: turbo_stream.update(@circuit, 
          partial: "circuits/form", 
          locals: {circuit: @circuit})
      end
    end

  end

  def create
    @circuit = Circuit.new(circuit_params)
  
    respond_to do |format|
      if @circuit.save
        flash.now[:success] = "circuit was successfully created"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_circuit',
                                partial: "circuits/form",
                                locals: { circuit: Circuit.new }),
  
            turbo_stream.append('circuits',
                                 partial: "circuits/circuit",
                                 locals: { circuit: @circuit }),
            turbo_stream.prepend('flash', partial: 'layouts/flash', locals: { flash: flash })

          ]
        end
  
        format.html { redirect_to circuit_url(@circuit), notice: "Circuit was successfully created." }
        format.json { render :show, status: :created, location: @circuit }
      else
        format.turbo_stream do
          render turbo_stream.update(
            'new_circuit',
            partial: "circuits/form",
            locals: { circuit: @circuit }
          )
        end
  
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @circuit.errors, status: :unprocessable_entity }
      end
    end
  end
  

  def update
    respond_to do |format|
      if @circuit.update(circuit_params)
        flash.now[:success] = "circuit was successfully updated"

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update(@circuit, 
                    partial: 'circuits/circuit', 
                    locals: { circuit: @circuit }),

            turbo_stream.prepend('flash',
              partial: 'layouts/flash', locals: { flash: flash })
          
          ]
        end

        format.html { redirect_to circuit_url(@circuit), notice: "Circuit was successfully updated." }
        format.json { render :show, status: :ok, location: @circuit }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@circuit, 
                    partial: 'circuits/form', 
                    locals: { circuit: @circuit })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @circuit.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @circuit.destroy

    respond_to do |format|
      format.html { redirect_to circuits_url, notice: "Circuit was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def authorize_admin
    unless current_user && current_user.admin 
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end

  def set_circuit
    @circuit = Circuit.find(params[:id])
  end

  def circuit_params
    params.require(:circuit).permit(:nom, :pays, :latitude, :longitude, :drapeau)
  end

end
