class AssociationUser < ApplicationRecord
  belongs_to :user
  belongs_to :ligue
  belongs_to :division, :optional => true
  belongs_to :equipe, :optional => true

  belongs_to :rattachement, :optional => true

  has_many :resultats, dependent: :destroy

  before_create :verif_doublon_user
  before_update :verif_doublon_user

  def self.ransackable_attributes(auth_object = nil)
    ["actif", "admin", "created_at", "division_id", "equipe_id", "id", "ligue_id", "pilote", "updated_at", "user_id", "valide"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["division", "equipe", "ligue", "rattachement", "resultats", "user"]
  end

  def self.recent(limit = 5)
    order(created_at: :desc).limit(limit)
  end

  
  private

  # passer les autres asso user de ce user inactif pour garder la courante 
  def verif_doublon_user
    existing_active_association_user = AssociationUser.find_by(
      user_id: self.user_id,
      division_id: self.division_id,
      actif: true
    )
    
    # si meme user deja dans div et actif et asso courante actif et valide
    # passer les autres passifs pour ne pas avoir de doublons actifs
    if existing_active_association_user && self.actif && self.valide

      puts "_______________existing active asso user with same use: #{existing_active_association_user}"
      
      AssociationUser.where(
        user_id: existing_active_association_user.user_id,
        division_id: existing_active_association_user.division_id
        ).update_all(actif: false)
        
    end
  end
  
end
