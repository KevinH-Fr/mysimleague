class CreateDotds < ActiveRecord::Migration[7.0]
  def change
    create_table :dotds do |t|
      t.references :user, null: false, foreign_key: true
      t.references :association_user, null: false, foreign_key: true
      t.references :event, null: false, foreign_key: true

      t.timestamps
    end
  end
end
