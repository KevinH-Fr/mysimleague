class Dotd < ApplicationRecord
  belongs_to :user
  belongs_to :association_user
  belongs_to :event


  def self.ransackable_attributes(auth_object = nil)
    ["association_user_id", "created_at", "event_id", "id", "updated_at", "user_id"]
  end
  
end
