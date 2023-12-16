class CreateSetups < ActiveRecord::Migration[7.0]
  def change
    create_table :setups do |t|
      t.references :game, null: false, foreign_key: true
      t.string :nom

      t.timestamps
    end
  end
end
