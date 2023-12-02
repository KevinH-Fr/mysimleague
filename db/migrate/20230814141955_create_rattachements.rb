class CreateRattachements < ActiveRecord::Migration[7.0]
  def change
    create_table :rattachements do |t|
      t.references :user, null: false, foreign_key: true
      t.references :ligue, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
