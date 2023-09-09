class AddContentsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :slogan, :text
    add_column :users, :bio, :text
    add_column :users, :controlleur_type, :string
    add_column :users, :pilote_prefere, :string
  end
end
