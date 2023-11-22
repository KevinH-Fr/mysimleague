module ScoringUpdateHelper
 
include ScoringHelper

    def update_scoring
        users = User.includes(:paris, :dotds).all #, :events

        users.each do |user|
            profile_edit_points = scoring_edit_profile(user)
            user.update(edit_profile_score: profile_edit_points)
        end

    end

end 
