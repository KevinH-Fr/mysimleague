class AddLicenceEquipeToDivisions < ActiveRecord::Migration[7.0]
  def change
    add_column :divisions, :licence_equipe, :boolean
  end
end
