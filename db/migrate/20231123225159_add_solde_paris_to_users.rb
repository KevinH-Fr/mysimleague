class AddSoldeParisToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :solde_paris, :integer
  end
end
