class Rattachement < ApplicationRecord
  belongs_to :user
  belongs_to :ligue

  has_one :association_user
  accepts_nested_attributes_for :association_user


  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "ligue_id", "message", "updated_at", "user_id"]
  end
   
end
