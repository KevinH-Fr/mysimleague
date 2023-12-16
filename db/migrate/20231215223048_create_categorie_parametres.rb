class CreateCategorieParametres < ActiveRecord::Migration[7.0]
  def change
    create_table :categorie_parametres do |t|
      t.references :game, null: false, foreign_key: true
      t.string :val_categorie

      t.timestamps
    end
  end
end
