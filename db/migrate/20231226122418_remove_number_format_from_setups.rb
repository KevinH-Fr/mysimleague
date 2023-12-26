class RemoveNumberFormatFromSetups < ActiveRecord::Migration[7.0]
  def change
    remove_column :setups, :number_format
  end
end
