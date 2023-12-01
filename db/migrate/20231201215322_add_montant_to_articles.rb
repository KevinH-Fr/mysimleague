class AddMontantToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :montant, :integer
  end
end
