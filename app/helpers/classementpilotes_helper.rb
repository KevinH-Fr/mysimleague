module ClassementpilotesHelper

    def points_by_pilote
        @pilotes = filtreDivisionCourante.includes(:resultats)
        @points_by_pilote = {}
        @pilotes.each do |pilote|
          score_sum = pilote.resultats.sum(:score)
          @points_by_pilote[pilote] = score_sum
        end
        @points_by_pilote.sort_by {|k, v| -v}.to_h
    end

end
