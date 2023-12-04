class BonusParisController < InheritedResources::Base

  before_action :authorize_admin, only: %i[ index new create edit update destroy ]

  private

    def bonus_pari_params
      params.require(:bonus_pari).permit(:user_id, :montant)
    end

    def authorize_admin
      unless current_user && current_user.admin 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
    
end
