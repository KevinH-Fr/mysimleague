class Setup < ApplicationRecord
  belongs_to :game
  has_many :parametre_setups, dependent: :destroy
  
  after_create :create_parametre_setups_for_related_base_setups

  private

  def create_parametre_setups_for_related_base_setups
    # Assuming you have a method to fetch related base_setups
    related_base_setups = BaseSetup.where(game: self.game_id)

    # Create parametre_setups for each related base_setup
    related_base_setups.each do |related_base_setup|
      parametre_setups.create(
        base_setup: related_base_setup,
        val_parametre: 0  # Replace with the default value or logic
      )
    end
  end
end
