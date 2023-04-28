module PilotesHelper

    def divisionCourante()
    	params[:divisionId]
    end

    def filtreDivisionCourante()
        if divisionCourante.present?
            division = Division.find(divisionCourante) 
            division.pilotes
        end
    end
end
