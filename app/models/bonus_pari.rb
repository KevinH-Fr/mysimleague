class BonusPari < ApplicationRecord
  include ParieursHelper

  belongs_to :user

  after_create :update_user_solde_paris

  private

  def update_user_solde_paris
    user.solde_paris = solde_paris(user)    
    user.save
  end
 
end
