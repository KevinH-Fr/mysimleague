class CreateLicencesEquipe < ActiveRecord::Migration[7.0]
  def change
    create_table :licences_equipes do |t|
      t.references :event, null: false, foreign_key: true
      t.references :equipe, null: false, foreign_key: true
      t.integer :gain
      t.integer :perte

      t.timestamps
    end
  end
end
