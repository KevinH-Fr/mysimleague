class CreateSaisons < ActiveRecord::Migration[7.0]
  def change
    create_table :saisons do |t|
      t.string :nom
      t.integer :numero

      t.timestamps
    end
  end
end
