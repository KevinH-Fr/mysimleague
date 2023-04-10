class Ligue < ApplicationRecord

    has_many :saisons

    def feed_content
        nom
     end 

end
