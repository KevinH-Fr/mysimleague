class CreateComportementBaseSetups < ActiveRecord::Migration[7.0]
  def change
    create_table :comportement_base_setups do |t|
      t.references :base_setup, null: false, foreign_key: true
      t.references :comportement, null: false, foreign_key: true
      t.string :sens

      t.timestamps
    end
  end
end
