class CreateLicences < ActiveRecord::Migration[7.0]
  def change
    create_table :licences do |t|
      t.references :event, null: false, foreign_key: true
      t.references :association_user, null: false, foreign_key: true
      t.integer :gain
      t.integer :perte

      t.timestamps
    end
  end
end
