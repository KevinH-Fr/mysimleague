class AddActifToEquipes < ActiveRecord::Migration[7.0]
  def change
    add_column :equipes, :actif, :boolean
  end
end
