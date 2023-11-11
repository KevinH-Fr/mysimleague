class RivalitesController < InheritedResources::Base

  def create
    @rivalite = Rivalite.new(rivalite_params)

    respond_to do |format|
      if @rivalite.save

        format.html { redirect_to rivalites_path, notice: "rivalite was successfully created." }
        format.json { render :show, status: :created, location: @rivalite }
      else

        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @rivalite.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def rivalite_params
      params.require(:rivalite).permit(:division_id, :pilote1_id, :pilote2_id, :statut)
    end

end
