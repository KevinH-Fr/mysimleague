class ComportementBaseSetupsController < InheritedResources::Base

  private

    def comportement_base_setup_params
      params.require(:comportement_base_setup).permit(:base_setup_id, :comportement_id, :sens)
    end

end
