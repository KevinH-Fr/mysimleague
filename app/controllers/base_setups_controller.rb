class BaseSetupsController < InheritedResources::Base

  private

    def base_setup_params
      params.require(:base_setup).permit(:parametre, :val_min, :val_max, :explication)
    end

end
