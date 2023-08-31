# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  def new

    super do |resource|
    end

  end


  def after_sign_up_path_for(resource)
      root_path
  end

  def index  
  end
  
   def edit
     super
   end

  private

  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation, :nom, :visiteur, :pilote, :admin)
  end

  def account_update_params
    params.require(:user).permit(:email, :password, :password_confirmation, :current_password, :nom, :visiteur, :pilote, :admin)
  end
end
