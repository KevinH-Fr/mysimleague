class ChangeDemandeurIdToAllowNullInDois < ActiveRecord::Migration[7.0]
  def change
    change_column :dois, :demandeur_id, :integer, null: true
  end
end
