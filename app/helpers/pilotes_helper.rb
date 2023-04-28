module PilotesHelper

    def divisionCourante()
    	params[:divisionId]
    end

    def pilotesFiltreDivisionCourante()
        if divisionCourante.present?
            division = Division.find(divisionCourante) 
            division.pilotes
        end
    end
end
