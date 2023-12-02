class CreateDivisions < ActiveRecord::Migration[7.0]
  def change
    create_table :divisions do |t|
      t.references :saison, null: false, foreign_key: true
      t.string :nom

      t.timestamps
    end
  end
end
