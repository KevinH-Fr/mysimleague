class Game < ApplicationRecord
    has_many :setups


    def game_version
        "#{self.nom} #{self.version}"
    end
end
