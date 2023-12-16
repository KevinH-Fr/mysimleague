class ProblemsController < InheritedResources::Base

  private

    def problem_params
      params.require(:problem).permit(:nom)
    end

end
