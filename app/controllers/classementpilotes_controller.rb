class ClassementpilotesController < ApplicationController
    def index
        @ligues = Ligue.all
        @saisons = Saison.all
        @divisions = Division.all
        @events = Event.all
        
        @ligueId = params[:ligueId]
        @saisonId = params[:saisonId]
        @divisionId = params[:divisionId]
        @eventId = params[:eventId]
    end
end
