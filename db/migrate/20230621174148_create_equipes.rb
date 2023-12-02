class CreateEquipes < ActiveRecord::Migration[7.0]
  def change
    create_table :equipes do |t|
      t.string :nom
      t.string :couleurs

      t.timestamps
    end
  end
end
