class AddRolesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :visiteur, :boolean
    add_column :users, :pilote, :boolean
    add_column :users, :admin, :boolean

  end
end
