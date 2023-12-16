class SetupsController < InheritedResources::Base

  private

    def setup_params
      params.require(:setup).permit(:game_id, :nom)
    end

end
