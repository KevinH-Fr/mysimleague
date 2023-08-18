class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.references :circuit, null: false, foreign_key: true
      t.references :division, null: false, foreign_key: true
      t.datetime :horaire
      t.integer :numero

      t.timestamps
    end
  end
end
