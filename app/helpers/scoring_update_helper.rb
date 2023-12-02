module ScoringUpdateHelper
 
include ScoringHelper
include UsersHelper

    def update_scoring_users
        users = User.includes(:paris, :dotds).all

        users.each do |user|
            profile_edit_points = scoring_edit_profile(user)
            user.update(edit_profile_score: profile_edit_points)

            count_paris = user.paris.size
            user.update(paris_score: count_paris)

            count_dotds = user.dotds.size
            user.update(dotds_score: count_dotds)

        end

    end

    def update_scoring_pilotes
        users = User.all 

        users.each do |user|
            score_pilote = scoring_pilote_sum(user)
            user.update(score_pilote: score_pilote)

        end

    end

end 
