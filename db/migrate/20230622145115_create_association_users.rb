class CreateAssociationUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :association_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ligue, null: false, foreign_key: true
      t.references :division, null: true, foreign_key: true
      t.references :equipe, null: true, foreign_key: true
      t.references :rattachement, null: true, foreign_key: true

      t.boolean :pilote
      t.boolean :admin
      t.boolean :valide
      t.boolean :actif

      t.timestamps
    end
  end
end
