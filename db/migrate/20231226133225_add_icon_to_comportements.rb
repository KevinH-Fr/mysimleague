class AddIconToComportements < ActiveRecord::Migration[7.0]
  def change
    add_column :comportements, :icon, :string
  end
end
