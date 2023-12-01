class CreatePurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :purchases do |t|
      t.string :status
      t.references :article, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.string :stripe_ref

      t.timestamps
    end
  end
end
