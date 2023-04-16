class Saison < ApplicationRecord

    belongs_to :ligue, optional: true
    has_many :divisions, dependent: :delete_all

    def feed_content
        nom
     end 
end
