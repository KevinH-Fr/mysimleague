class Dotd < ApplicationRecord
  belongs_to :user
  belongs_to :association_user
  belongs_to :event

  after_create :increment_user_scoring_dotds


  def self.ransackable_attributes(auth_object = nil)
    ["association_user_id", "created_at", "event_id", "id", "updated_at", "user_id"]
  end
  
end

private

def increment_user_scoring_dotds
  user.increment!(:dotds_score, 1)
end