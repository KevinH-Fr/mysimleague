class CreateBaseSetups < ActiveRecord::Migration[7.0]
  def change
    create_table :base_setups do |t|
      t.string :parametre
      t.decimal :val_min
      t.decimal :val_max
      t.text :explication

      t.timestamps
    end
  end
end
