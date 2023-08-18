class CreateResultats < ActiveRecord::Migration[7.0]
  def change
    create_table :resultats do |t|
      t.references :event, null: false, foreign_key: true
      t.references :association_user, null: false, foreign_key: true
      t.references :equipe, null: false, foreign_key: true
      t.string :qualification
      t.string :qualification_sprint
      t.string :course
      t.boolean :dotd
      t.boolean :mt
      t.integer :score
      t.boolean :dnf
      t.boolean :dns

      t.timestamps
    end
  end
end
