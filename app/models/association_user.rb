class AssociationUser < ApplicationRecord
  belongs_to :user
  belongs_to :ligue
  belongs_to :division, :optional => true
  belongs_to :equipe, :optional => true

  belongs_to :rattachement, :optional => true

  has_many :resultats, dependent: :destroy


  def self.ransackable_attributes(auth_object = nil)
    ["actif", "admin", "created_at", "division_id", "equipe_id", "id", "ligue_id", "pilote", "updated_at", "user_id", "valide"]
  end

end
