class RemoveNotNullColumnFromEvents < ActiveRecord::Migration[7.0]
  def change
    change_column_null :events, :ligue_id, true
  end
end
