class AddScorePiloteToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :score_pilote, :integer
  end
end
