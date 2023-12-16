class CorrectionsController < InheritedResources::Base

  private

    def correction_params
      params.require(:correction).permit(:base_setup_id, :setup_id, :nom, :sens, :problem_id, :problem_second_id)
    end

end
