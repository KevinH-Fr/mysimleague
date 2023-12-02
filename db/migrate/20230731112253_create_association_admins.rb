class CreateAssociationAdmins < ActiveRecord::Migration[7.0]
  def change
    create_table :association_admins do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ligue, null: false, foreign_key: true
      t.boolean :admin
      t.boolean :valide
      t.boolean :actif

      t.timestamps
    end
  end
end
