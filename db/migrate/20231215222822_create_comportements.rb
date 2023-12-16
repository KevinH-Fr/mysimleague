class CreateComportements < ActiveRecord::Migration[7.0]
  def change
    create_table :comportements do |t|
      t.string :nom
      t.boolean :principal
      t.string :label_categorie

      t.timestamps
    end
  end
end
