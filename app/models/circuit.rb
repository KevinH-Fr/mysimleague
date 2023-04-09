class Circuit < ApplicationRecord
    has_many :events

    def feed_content
        nom
      end 
end
