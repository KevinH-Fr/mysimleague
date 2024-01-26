class UsersController < ApplicationController

  include UsersHelper

  def show
    @user = User.includes(association_users: [{ equipe: {banniere_attachment: :blob} }, :division])
    .find(params[:id])

    @user_compare = nil

    stats = user_resultats_stats(@user, @user_compare)
    @data = [ 
      stats[:user_stats][:nb_victoires],
      stats[:user_stats][:nb_podiums],
      stats[:user_stats][:nb_top5],
      stats[:user_stats][:nb_top10],      
    ]
    @data_compare = []

    resultats = user_resultats_scores(@user, @user_compare)
    @data_resultats = resultats.to_json
    @data_resultats_compare = []

  end

  def create
    @user.twitch = sanitize(params[:user][:twitch])
  end

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).order(:nom)
  end

  def edit
    @user = User.find(params[:id])
    @user.twitch = sanitize(params[:user][:twitch])
  end

  def update
    @user = User.find(params[:id])
  end


end
