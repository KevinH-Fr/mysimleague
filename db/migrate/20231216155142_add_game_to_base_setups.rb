class AddGameToBaseSetups < ActiveRecord::Migration[7.0]
  def change
    add_reference :base_setups, :game, null: false, foreign_key: true
  end
end
