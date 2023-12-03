class AddContentToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :niveau, :integer
    add_column :articles, :bonus_paris, :integer

  end
end
