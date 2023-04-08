class CreateFriends < ActiveRecord::Migration[7.0]
  def change
    create_table :friends do |t|
      t.string :nom
      t.integer :age
      t.text :description

      t.timestamps
    end
  end
end
