class DropCorrections < ActiveRecord::Migration[7.0]
  def change
    drop_table :corrections
  end
end
