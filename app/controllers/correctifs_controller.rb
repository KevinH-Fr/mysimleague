class CorrectifsController < ApplicationController
  before_action :set_correctif, only: %i[ show edit update destroy ]

  def index
   # @correctifs = Correctif.all.group_by(&:problem_second)
    @correctifs = Correctif.all

  end

  def new
    @correctif = Correctif.new correctif_params
  end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(@correctif, partial: 'correctifs/form', locals: { correctif: @correctif })
      end
    end
  end

  def create
    @correctif = Correctif.new(correctif_params)

    respond_to do |format|
      if @correctif.save

        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.update('new_correctif', partial: 'correctifs/form', locals: { correctif: Correctif.new }),
            turbo_stream.prepend('correctifs', partial: 'correctifs/correctif', locals: { correctif: @correctif })
          ]
          format.html { redirect_to correctif_url(@correctif), notice: "correctif was successfully created." }
          format.json { render :show, status: :created, location: @correctif }
        end

      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update('new_correctif', partial: 'correctifs/form', locals: { correctif: @correctif})
        end

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @correctif.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @correctif.update(correctif_params)

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@correctif, partial: 'correctifs/correctif', locals: { correctif: @correctif })
        end

        format.html { redirect_to correctif_url(@correctif), notice: "correctif was successfully updated." }
        format.json { render :show, status: :ok, location: @correctif }
      else

        format.turbo_stream do
          render turbo_stream: turbo_stream.update(@correctif, partial: 'correctifs/form', locals: { correctif: @correctif })
        end

        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @correctif.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /correctifs/1 or /correctifs/1.json
  def destroy
    @correctif.destroy!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@correctif) }
      format.html { redirect_to correctifs_url, notice: "correctif was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_correctif
    @correctif = Correctif.find(params[:id])
  end


    def correctif_params
      params.fetch(:correctif, {}).permit(:base_setup_id, :setup_id, :nom, :sens, :problem_id, :problem_second_id)
    end

end
