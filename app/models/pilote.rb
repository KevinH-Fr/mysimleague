class Pilote < ApplicationRecord
   validates :nom, presence: true

   def feed_content
      nom
   end 
end
