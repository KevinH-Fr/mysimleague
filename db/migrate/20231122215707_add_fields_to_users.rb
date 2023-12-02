class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :paris_score, :integer
    add_column :users, :dotds_score, :integer
  end
end
