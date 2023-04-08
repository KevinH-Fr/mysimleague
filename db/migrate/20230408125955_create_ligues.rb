class CreateLigues < ActiveRecord::Migration[7.0]
  def change
    create_table :ligues do |t|
      t.string :nom
      t.text :description

      t.timestamps
    end
  end
end
