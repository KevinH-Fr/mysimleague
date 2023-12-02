class AddTimeZoneToLigues < ActiveRecord::Migration[7.0]
  def change
    add_column :ligues, :time_zone, :string
  end
end
