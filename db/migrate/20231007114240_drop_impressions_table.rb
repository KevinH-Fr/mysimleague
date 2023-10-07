class DropImpressionsTable < ActiveRecord::Migration[7.0]
  def up
    drop_table :impressions
  end

  def down
    create_table :impressions do |t|
      # Define the table columns if needed
      t.integer :impressionable_id
      t.string :impressionable_type
      t.string :controller_name
      t.string :action_name
      t.string :view_name
      t.string :request_hash
      t.string :ip_address
      t.references :user, polymorphic: true
      t.timestamps null: false
    end
  end
end
