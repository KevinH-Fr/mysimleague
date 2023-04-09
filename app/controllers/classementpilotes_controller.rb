class ClassementpilotesController < ApplicationController
    def index
        @ligues = Ligue.all
        @saisons = Saison.all
        
        @ligueId = params[:ligueId]
        @saisonId = params[:saisonId]
    end
end
