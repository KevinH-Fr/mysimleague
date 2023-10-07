class Resultat < ApplicationRecord
  belongs_to :event
  belongs_to :association_user
  belongs_to :equipe

  attribute :score, :integer, default: 0
  
  def feed_content
    id
  end 
   
  def self.ransackable_attributes(auth_object = nil)
    ["association_user_id", "course", "created_at", "dnf", "dns", "dotd", "equipe_id", "event_id", "id", "mt", "qualification", "qualification_sprint", "score", "updated_at"]
  end

end
