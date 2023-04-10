class AddLigueToSaisons < ActiveRecord::Migration[7.0]
  def change
    add_reference :saisons, :ligue, null: true, foreign_key: true
  end
end
