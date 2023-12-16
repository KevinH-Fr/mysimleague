class CreateParametreSetups < ActiveRecord::Migration[7.0]
  def change
    create_table :parametre_setups do |t|
      t.references :setup, null: false, foreign_key: true
      t.references :base_setup, null: false, foreign_key: true
      t.decimal :val_parametre
      t.boolean :filled

      t.timestamps
    end
  end
end
