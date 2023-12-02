class Saison < ApplicationRecord
  belongs_to :ligue
  has_many :divisions, dependent: :destroy

  validates :nom, presence: true
  validates :ligue_id, presence: true

  def feed_content
    id
  end 

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "ligue_id", "nom", "updated_at"]
  end
  
end
