module ScoringUpdateHelper
 
include ScoringHelper

    def update_scoring
        users = User.includes(:paris, :dotds).all #, :events

        users.each do |user|
            profile_edit_points = scoring_edit_profile(user)
            user.update(edit_profile_score: profile_edit_points)

            count_paris = user.paris.size
            user.update(paris_score: count_paris)

            count_dotds = user.dotds.size
            user.update(dotds_score: count_dotds)

            #ajouter les autres elements à updater 

        end

    end

end 
