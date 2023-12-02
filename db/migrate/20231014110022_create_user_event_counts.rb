class CreateUserEventCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :user_event_counts do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :event_count

      t.timestamps
    end
  end
end
