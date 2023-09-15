class HomeController < ApplicationController
 # include FeedsHelper
  include UsersHelper

  def index
 
    @prochains_events = Event.where('horaire >= ?', Date.today).order(:horaire).limit(4)

    if current_user
      @current_user
    end
  
  end 

  def display_feeds
    #  feeds = feeds_elements

    models_to_fetch = [User, AssociationUser, Event, Resultat, Doi, Pari, Dotd]
    # models enlevés : Ligue Saison Division Circuit Equipe
    @feeds = []

    # Iterate through the models and fetch the most recent 3 records for each
    models_to_fetch.each do |model|
      # Use the 'or' method to build a query for each model
      recent_records = model.order(updated_at: :desc).limit(3)
      @feeds += recent_records
    end

    @feeds.sort_by!(&:updated_at).reverse!


  #@pagy, feeds = pagy(feeds, items: 5)

    @pagy, @feeds = pagy_array(@feeds, items: 5)

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'home/feeds'
        )
      end
    end

    
  end

  def display_parieurs

   # @event = Event.find(session[:event])

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'home/parieurs'
        )
      end
    end
  end

  def display_parieurs_annee

  #  @event = Event.find(session[:event])
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

  def display_pilotes 

    @pilotes = User.all 

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.update(
          'partial-container', partial: 'home/pilotes'
        )
      end
    end

  end


  def display_creer_ligue
    redirect_to menu_index_path
  end

  def display_comparaison_stats

    @user = User.find(params[:id])

    selected_option = params[:select_option]
    @user_compare = User.find(selected_option) if selected_option

    # datas pour chartradar
    stats = user_resultats_stats(@user, @user_compare)
    @data = [ 
      stats[:user_stats][:nb_victoires],
      stats[:user_stats][:nb_podiums],
      stats[:user_stats][:nb_top5],
      stats[:user_stats][:nb_top10]
    ]

    @data_compare = [
      stats[:user_compare_stats][:nb_victoires],
      stats[:user_compare_stats][:nb_podiums],
      stats[:user_compare_stats][:nb_top5],
      stats[:user_compare_stats][:nb_top10]
    ] if @user_compare

    # datas pour chartline
    resultats = user_resultats_scores(@user, @user_compare)
    @data_resultats = resultats.to_json

    @data_resultats_compare = []

    respond_to do |format|
      
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.update(
          'partial-container', 
          partial: 'users/tableau_statistiques',
          locals: {user: @user}
        ),
        turbo_stream.prepend(
          'partial-container', 
          partial: 'users/chartline',
          locals: {user: @user}
        ),
        turbo_stream.prepend(
          'partial-container', 
          partial: 'users/chartradar',
          locals: {user: @user}
        ),
      ]
      end
    end
  end
    
end
