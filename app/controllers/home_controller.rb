class HomeController < ApplicationController
  include FeedsHelper
  
  def index
    feeds = feeds_elements

    @prochains_events = Event.where('horaire >= ?', Date.today).order(:horaire).limit(5)

    if current_user
      @current_user
    end
  
  end 

  def display_parieurs

    @event = Event.find(session[:event])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'home/parieurs'
        )
      end
    end
  end

  def display_parieurs_annee

    @event = Event.find(session[:event])
    @annee = params[:annee]

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'home/parieurs'
        )
      end
    end
  end

  def display_demande_rattachement

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'home/rattachements'
        )
      end
    end
  end


  def display_creer_ligue
    redirect_to menu_index_path
  end
    
end
