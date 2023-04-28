module ClassementpilotesHelper

    # classement avec index et tri
    def points_by_pilote
        @pilotes = filtreDivisionCourante.includes(:resultats)
        @points_by_pilote = {}
        @pilotes.each_with_index do |pilote, index|
          score_sum = pilote.resultats.sum(:score)
          @points_by_pilote[pilote] = { score: score_sum, index: index + 1 }
        end
        @points_by_pilote.sort_by { |_, v| -v[:score] }.to_h
      end
      
end
