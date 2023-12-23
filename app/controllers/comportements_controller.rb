class ComportementsController < ApplicationController
  before_action :set_comportement, only: %i[ show edit update destroy ]
  before_action :authorize_admin, only: %i[ new create edit update index destroy ]

  def index
    @comportements = Comportement.all
    @comportements_grouped = @comportements.group_by(&:label_categorie)

  end

  def show
  end

  def new
    @comportement = Comportement.new
  end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@comportement, partial: 'comportements/form', locals: { comportement: @comportement })
      end
    end
  end

  # POST /comportements or /comportements.json
  def create
    @comportement = Comportement.new(comportement_params)

    respond_to do |format|
      if @comportement.save

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_comportement', partial: 'comportements/form', locals: { comportement: Comportement.new }),
            turbo_stream.prepend('comportements', partial: 'comportements/comportement', locals: { comportement: @comportement })
          ]
          format.html { redirect_to comportement_url(@comportement), notice: "Comportement was successfully created." }
          format.json { render :show, status: :created, location: @comportement }
        end

      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update('new_comportement', partial: 'comportements/form', locals: { comportement: @comportement})
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @comportement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comportements/1 or /comportements/1.json
  def update
    respond_to do |format|
      if @comportement.update(comportement_params)

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@comportement, partial: 'comportements/comportement', locals: { comportement: @comportement })
        end

        format.html { redirect_to comportement_url(@comportement), notice: "Comportement was successfully updated." }
        format.json { render :show, status: :ok, location: @comportement }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@comportement, partial: 'comportements/form', locals: { comportement: @comportement })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @comportement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comportements/1 or /comportements/1.json
  def destroy
    @comportement.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@comportement) }
      format.html { redirect_to comportements_url, notice: "Comportement was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comportement
      @comportement = Comportement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comportement_params
      params.require(:comportement).permit(:nom, :principal, :label_categorie)
    end

    def authorize_admin
      unless current_user && current_user.admin 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
end
