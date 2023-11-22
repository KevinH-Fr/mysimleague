class AddEditProfileScoreToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :edit_profile_score, :integer
  end
end
