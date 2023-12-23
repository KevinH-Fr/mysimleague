class AddCircuitToSetups < ActiveRecord::Migration[7.0]
  def change
    add_reference :setups, :circuit, foreign_key: true
  end
end
