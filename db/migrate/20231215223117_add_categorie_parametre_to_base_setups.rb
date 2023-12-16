class AddCategorieParametreToBaseSetups < ActiveRecord::Migration[7.0]
  def change
    add_reference :base_setups, :categorie_parametre, foreign_key: true
  end
end
