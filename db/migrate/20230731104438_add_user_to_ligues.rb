class AddUserToLigues < ActiveRecord::Migration[7.0]
  def change
    add_reference :ligues, :user, foreign_key: true
  end
end
