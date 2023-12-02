class AddPointsInitialToLigues < ActiveRecord::Migration[7.0]
  def change
    add_column :ligues, :points_initial, :integer
  end
end
