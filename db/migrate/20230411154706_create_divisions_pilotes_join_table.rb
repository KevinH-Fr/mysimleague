class CreateDivisionsPilotesJoinTable < ActiveRecord::Migration[7.0]
  def change
    create_table :divisions_pilotes, id: false do |t|
      t.references :pilote, null: false, foreign_key: true
      t.references :division, null: false, foreign_key: true
    end
    add_index :divisions_pilotes, [:pilote_id, :division_id], unique: true
  end
end
