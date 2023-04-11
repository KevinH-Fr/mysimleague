class Equipe < ApplicationRecord

  has_one_attached :logo

  def feed_content
    nom
  end 
end
