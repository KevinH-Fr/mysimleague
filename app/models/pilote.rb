class Pilote < ApplicationRecord
   
   has_many :events
   validates :nom, presence: true

   def feed_content
      nom
   end 

end
