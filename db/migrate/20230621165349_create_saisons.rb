class CreateSaisons < ActiveRecord::Migration[7.0]
  def change
    create_table :saisons do |t|
      t.references :ligue, null: false, foreign_key: true
      t.string :nom

      t.timestamps
    end
  end
end
