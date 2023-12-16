class ProblemSecondsController < InheritedResources::Base

  def create
    @problem_second = ProblemSecond.new(problem_second_params)

    respond_to do |format|
      if @problem_second.save

          format.html { redirect_to problems_url(), notice: "Probleme second was successfully created." }
          format.json { render :show, status: :created, location: @problem_second }
      else


        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @problem_second.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def problem_second_params
      params.require(:problem_second).permit(:problem_id, :nom)
    end

end
