class DropUserEventCounts < ActiveRecord::Migration[7.0]
  def change
    drop_table :user_event_counts
  end
end
