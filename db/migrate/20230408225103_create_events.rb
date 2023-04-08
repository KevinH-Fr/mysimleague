class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.date :date
      t.time :horaire
      t.integer :numero
      t.references :circuit, null: false, foreign_key: true
      t.references :saison, null: false, foreign_key: true
      t.references :division, null: false, foreign_key: true
      t.references :ligue, null: false, foreign_key: true

      t.timestamps
    end
  end
end
