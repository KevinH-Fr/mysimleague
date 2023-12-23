class AddUserToSetups < ActiveRecord::Migration[7.0]
  def change
    add_reference :setups, :user, foreign_key: true
  end
end
