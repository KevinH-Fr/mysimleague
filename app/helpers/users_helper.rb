module UsersHelper
  
    def divisions_for_current_user
        current_user.association_users.includes(:division).map(&:division).uniq
    end


end
  