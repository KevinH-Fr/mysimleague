class ParametreSetupsController < InheritedResources::Base

  private

    def parametre_setup_params
      params.require(:parametre_setup).permit(:setup_id, :base_setup_id, :val_parametre, :filled)
    end

end
