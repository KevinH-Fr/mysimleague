class AddRattachementToAssociationUsers < ActiveRecord::Migration[7.0]
  def change
    add_reference :association_users, :rattachement, null: true, foreign_key: true
  end
end
