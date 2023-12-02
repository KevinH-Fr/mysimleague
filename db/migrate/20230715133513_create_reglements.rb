class CreateReglements < ActiveRecord::Migration[7.0]
  def change
    create_table :reglements do |t|
      t.references :ligue, null: true, foreign_key: true
      t.string :num_article
      t.string :titre_article
      t.text :contenu_article
      t.integer :penalite
      t.string :penalite_temps
      t.boolean :defaut

      t.timestamps
    end
  end
end
