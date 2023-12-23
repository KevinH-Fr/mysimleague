class AddCommentairesToSetups < ActiveRecord::Migration[7.0]
  def change
    add_column :setups, :commentaires, :text
  end
end
