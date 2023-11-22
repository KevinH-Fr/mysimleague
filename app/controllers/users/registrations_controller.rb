# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  include ScoringHelper

  def new

    super do |resource|
    end
    
  end
  
  
  def after_sign_up_path_for(resource)
    user_path(resource)
    
  end

  def index  
  end
  
  def edit
    super
  end

  def update
    super
    update_edit_profile_score(resource)
  end
  
  private

  def update_edit_profile_score(resource)
    resource.edit_profile_score = scoring_edit_profile(resource)
    resource.save
  end

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nom, :visiteur, :pilote, :admin,
                                  :profile_pic, :slogan, :bio, :controlleur_type, :pilote_prefere, :twitch, :edit_profile_score)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :nom, :visiteur, :pilote, :admin,
                                  :profile_pic, :slogan, :bio, :controlleur_type, :pilote_prefere, :twitch, :edit_profile_score)

  end
end

