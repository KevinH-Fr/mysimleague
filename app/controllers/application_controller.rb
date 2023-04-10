class ApplicationController < ActionController::Base
    include Pagy::Backend

    #before_action :set_global_variable

    private
    # variables communes pour tous les models avec choix event
    #def set_global_variable 
     #   @ligues = Ligue.all
     #   @saisons = Saison.all
     #   @divisions = Division.all
     #   @events = Event.all

     #   @ligueId = params[:ligueId]
     #   @saisonId = params[:saisonId]
     #   @divisionId = params[:divisionId]
     #   @eventId = params[:eventId]

    #end

end
