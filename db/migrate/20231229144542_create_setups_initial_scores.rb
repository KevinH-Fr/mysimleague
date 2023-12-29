class CreateSetupsInitialScores < ActiveRecord::Migration[7.0]
  def change
    create_table :setups_initial_scores do |t|
      t.references :setup, null: false, foreign_key: true
      t.references :comportement, null: false, foreign_key: true
      t.integer :initial_score

      t.timestamps
    end
  end
end

