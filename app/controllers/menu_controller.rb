class MenuController < ApplicationController

  def index
    @ligues = Ligue.all
    @ligue = Ligue.find(params[:ligue]) if params[:ligue]
    session[:ligue] = @ligue.id if @ligue

    @saisons = @ligue.saisons if @ligue
    @saison = Saison.find(params[:saison]) if params[:saison]
    session[:saison] = @saison.id if @saison

    @divisions = @saison.divisions if @saison
    @division = Division.find(params[:division]) if params[:division]
    session[:division] = @division.id if @division

    @circuits = Circuit.all if @division

    @events = @division.events.order(:numero) if @division
    @show_buttons = true #pour afficher les btns de event que depuis ce controller, pas depuis home index 
    @event = Event.find(params[:event]) if params[:event]
    session[:event] = @event.id if @event

    @previous_event = Event.where(division_id: @event.division_id, numero: @event.numero - 1).first if @event


  
  end

  def display_admins_ligue

    @ligue = Ligue.find(session[:ligue])
    @admins_ligue = @ligue.association_admins  

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-ligue-container', partial: 'menu/association_admins'
        )
      end
    end
  end

  def display_rattachements_ligue

    @ligue = Ligue.find(session[:ligue])
    @rattachements = @ligue.rattachements 

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-ligue-container', partial: 'menu/rattachements'
        )
      end
    end
  end

  def display_pilotes_division

    @division = Division.find(session[:division])
    @association_users = @division.association_users if @division 

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-division-container', partial: 'menu/pilotes_division'
        )
      end
    end
  end

  def display_dupliquer_events_division

    @division = Division.find(session[:division])
    @divisions = Division.where(saison_id: @division.saison_id)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-division-container', partial: 'menu/duplication_events'
        )
      end
    end
  end

  def display_reglements_ligue

    @ligue = Ligue.find(session[:ligue])

    if @ligue.reglement_defaut == true
      @reglements = Reglement.where(defaut: true)
    else
      @reglements = @ligue.reglements 
    end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-ligue-container', partial: 'menu/reglements'
        )
      end
    end
  end

  def display_resultats

    @equipes = Equipe.all
    @event = Event.find(session[:event])
    @resultats = @event.resultats  

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'menu/resultats'
        )
      end
    end
  end


  def display_presences

    @event = Event.find(session[:event])
    @presences = @event.presences if @event

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'menu/presences'
        )
      end
    end
  end

  def display_dotds

    @event = Event.find(session[:event])
    @dotds = @event.dotds if @event

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'menu/dotds'
        )
      end
    end
  end

  def display_dois

    @event = Event.find(session[:event])
    @dois = @event.dois if @event 

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'menu/dois'
        )
      end
    end
  end


  def display_paris

    @event = Event.find(session[:event])
    @paris = @event.paris if @event 

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'menu/paris'
        )
      end
    end
  end

  def display_licences

    @event = Event.find(session[:event])
    @licences = @event.licences if @event 

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'menu/licences'
        )
      end
    end
  end

  def display_synthese_licences
    @event = Event.find(session[:event])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'menu/synthese_licences'
        )
      end
    end
  end

  def display_classement_pilotes
    @event = Event.find(session[:event])
    @previous_event = Event.where(division_id: @event.division_id, numero: @event.numero - 1).first if @event

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'menu/classement_pilotes'
        )
      end
    end
  end

  def display_classement_equipes
    @event = Event.find(session[:event])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'menu/classement_equipes'
        )
      end
    end
  end

end
