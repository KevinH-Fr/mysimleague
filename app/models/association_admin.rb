class AssociationAdmin < ApplicationRecord
  belongs_to :user
  belongs_to :ligue

  def self.ransackable_attributes(auth_object = nil)
    ["actif", "admin", "created_at", "id", "ligue_id", "updated_at", "user_id", "valide"]
  end

  
end
