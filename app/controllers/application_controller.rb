class ApplicationController < ActionController::Base
    include Pagy::Backend

    before_action :set_global_variable

    private
    # variables communes pour tous les models avec choix event
    def set_global_variable 

        @liste_positions = (1..20).to_a
        
    end

end
