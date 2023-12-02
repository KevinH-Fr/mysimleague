class CreatePresences < ActiveRecord::Migration[7.0]
  def change
    create_table :presences do |t|
      t.references :event, null: false, foreign_key: true
      t.references :association_user, null: false, foreign_key: true
      t.boolean :status

      t.timestamps
    end
  end
end
