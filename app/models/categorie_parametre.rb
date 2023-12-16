class CategorieParametre < ApplicationRecord
  belongs_to :game
  has_many :base_setups
end
