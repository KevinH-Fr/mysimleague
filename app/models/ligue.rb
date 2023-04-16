class Ligue < ApplicationRecord

    has_many :saisons, dependent: :delete_all

    #permet d'avoir les div d'une lige via les saisons
    has_many :divisions, through: :saisons, dependent: :delete_all

    has_one_attached :icon

    def feed_content
        nom
     end 

end
