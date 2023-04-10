class RemoveColumnFromEvents < ActiveRecord::Migration[7.0]
  def change
    remove_column :events, :saison_id, :ligue_id
  end
end
