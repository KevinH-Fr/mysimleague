class ChangeSetupNullableToCorrectifs < ActiveRecord::Migration[7.0]
  def change
    change_column :correctifs, :setup_id, :integer, null: true
  end
end
