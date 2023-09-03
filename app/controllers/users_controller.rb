class UsersController < ApplicationController

  include UsersHelper

  def show
    @user = User.find(params[:id])

    @user_compare = nil

    stats = user_resultats_stats(@user, @user_compare)
    @data = [ 
      stats[:user_stats][:nb_victoires],
      stats[:user_stats][:nb_podiums],
      stats[:user_stats][:nb_victoires],
      stats[:user_stats][:nb_victoires],      
    ]
    @data_compare = []

    resultats = user_resultats_scores(@user, @user_compare)
    @data_resultats = resultats.to_json
    @data_resultats_compare = []

  end

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])

  end

end
