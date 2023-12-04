class CreateBonusParis < ActiveRecord::Migration[7.0]
  def change
    create_table :bonus_paris do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :montant

      t.timestamps
    end
  end
end
