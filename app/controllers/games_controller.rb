class GamesController < InheritedResources::Base

  before_action :authorize_admin, only: %i[ new create edit update index destroy ]

  private

    def game_params
      params.require(:game).permit(:nom, :version)
    end

    def authorize_admin
      unless current_user && current_user.admin 
        redirect_to root_path, alert: "You are not authorized to perform this action."
      end
    end
end
