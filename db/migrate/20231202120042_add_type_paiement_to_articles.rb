class AddTypePaiementToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :abonnement, :boolean
  end
end
