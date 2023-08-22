class Doi < ApplicationRecord
 # belongs_to :association_user
  belongs_to :event
  belongs_to :reglement, optional: true
  belongs_to :association_admin, optional: true


  enum responsable: [ :responsable, :fait_de_course ]

  def self.ransackable_attributes(auth_object = nil)
    ["commentaire", "created_at", "decision", "demandeur_id", "description", "event_id", "id", "implique_id", "lien", "penalite", "penalite_temps", "reglement_id", "updated_at"]
  end
  
end
