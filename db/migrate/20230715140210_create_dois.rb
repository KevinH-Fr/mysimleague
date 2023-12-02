class CreateDois < ActiveRecord::Migration[7.0]
  def change
    create_table :dois do |t|
      t.references :demandeur, null: false, foreign_key: { to_table: :association_users }
      t.references :implique, null: false, foreign_key: { to_table: :association_users }
      t.references :event, null: false, foreign_key: true
      t.text :description
      t.string :lien
      t.string :decision
      t.references :reglement, null: true, foreign_key: true
      t.integer :penalite
      t.string :penalite_temps
      t.text :commentaire


      t.timestamps
    end
  end
end
