class ChangeTypeCourseToResultats < ActiveRecord::Migration[7.0]
  def change
    change_column :resultats, :course, :integer
  end
end
