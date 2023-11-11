class CreateRivalites < ActiveRecord::Migration[7.0]
  def change
    create_table :rivalites do |t|
      t.references :division, null: false, foreign_key: true
      t.references :pilote1, null: false
      t.references :pilote2, null: false
      t.boolean :statut

      t.timestamps
    end
    add_foreign_key :rivalites, :association_users, column: :pilote1_id
    add_foreign_key :rivalites, :association_users, column: :pilote2_id
  end
end
