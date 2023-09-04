class ChangeTypeResultatToParis < ActiveRecord::Migration[7.0]
  def change
    change_column :paris, :resultat, :string
  end
end
