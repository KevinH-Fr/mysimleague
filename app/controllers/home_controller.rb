class HomeController < ApplicationController
  include FeedsHelper
  include UsersHelper
  
  def index
    feeds = feeds_elements

    @prochains_events = Event.where('horaire >= ?', Date.today).order(:horaire).limit(5)

    if current_user
      @current_user
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

   # @user = User.first
    @user = User.find(params[:id])

    selected_option = params[:select_option]
    @user_compare = User.find(selected_option) if selected_option

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

    puts "_____________________________________________________ user compare #{@user_compare.id}"

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
          partial: 'users/chartpie',
          locals: {user: @user}
        ),
        ]
      end
    end
  end
    
end
