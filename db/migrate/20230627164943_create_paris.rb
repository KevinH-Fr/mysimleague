class CreateParis < ActiveRecord::Migration[7.0]
  def change
    create_table :paris do |t|
      t.references :event, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.references :association_user, null: false, foreign_key: true
      t.decimal :montant
      t.string :typepari
      t.decimal :cote
      t.boolean :resultat
      t.decimal :solde

      t.timestamps
    end
  end
end
