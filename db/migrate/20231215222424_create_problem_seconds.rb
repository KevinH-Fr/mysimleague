class CreateProblemSeconds < ActiveRecord::Migration[7.0]
  def change
    create_table :problem_seconds do |t|
      t.string :nom

      t.timestamps
    end
  end
end
