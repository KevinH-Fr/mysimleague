class Pilote < ApplicationRecord
   
  belongs_to :event, optional: true

  has_many :participations
  has_many :divisions, through: :participations

   validates :nom, presence: true

   def feed_content
      nom
   end 

end
