class Licence < ApplicationRecord
  belongs_to :event
  belongs_to :association_user

  def self.ransackable_attributes(auth_object = nil)
    ["association_user_id", "created_at", "event_id", "gain", "id", "perte", "updated_at"]
  end
  
  def self.recent(limit = 5)
    order(created_at: :desc).limit(limit)
  end

  
end
