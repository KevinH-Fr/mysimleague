class Article < ApplicationRecord
    has_one_attached :image, dependent: :destroy
    has_many :purchases, dependent: :destroy

end
