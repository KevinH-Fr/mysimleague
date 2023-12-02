class AddDoicommissaireToDois < ActiveRecord::Migration[7.0]
  def change
    add_column :dois, :doicommissaire, :boolean
  end
end
