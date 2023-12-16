class CreateCorrections < ActiveRecord::Migration[7.0]
  def change
    create_table :corrections do |t|
      t.references :base_setup, null: false, foreign_key: true
      t.references :setup, null: true, foreign_key: true
      t.string :nom
      t.string :sens
      t.references :probleme, null: false, foreign_key: true
      t.references :probleme_second, null: false, foreign_key: true

      t.timestamps
    end
  end
end
