class AddNumberFormatToBaseSetups < ActiveRecord::Migration[7.0]
  def change
    add_column :base_setups, :number_format, :string
  end
end
