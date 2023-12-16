class AddProblemToProblemSeconds < ActiveRecord::Migration[7.0]
  def change
    add_reference :problem_seconds, :problem, null: false, foreign_key: true
  end
end
