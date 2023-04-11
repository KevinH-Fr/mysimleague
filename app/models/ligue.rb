class Ligue < ApplicationRecord

    has_many :saisons

    has_one_attached :icon

    def feed_content
        nom
     end 

end
