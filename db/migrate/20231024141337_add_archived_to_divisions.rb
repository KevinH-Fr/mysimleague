class AddArchivedToDivisions < ActiveRecord::Migration[7.0]
  def change
    add_column :divisions, :archived, :boolean
  end
end
