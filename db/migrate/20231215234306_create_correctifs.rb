class CreateCorrectifs < ActiveRecord::Migration[7.0]
  def change
    create_table :correctifs do |t|
      t.references :base_setup, null: false, foreign_key: true
      t.references :setup, null: false, foreign_key: true
      t.string :nom
      t.string :sens
      t.references :problem, null: false, foreign_key: true
      t.references :problem_second, null: false, foreign_key: true

      t.timestamps
    end
  end
end
