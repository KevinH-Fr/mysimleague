class AddAssociationAdminToDois < ActiveRecord::Migration[7.0]
  def change
    add_reference :dois, :association_admin, null: true, foreign_key: true
  end
end
