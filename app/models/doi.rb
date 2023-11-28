class Doi < ApplicationRecord
 # belongs_to :association_user
  belongs_to :event
  belongs_to :reglement, optional: true
  belongs_to :association_admin, optional: true

  validates_format_of :lien, with: /\A#{URI::DEFAULT_PARSER.make_regexp(%w[http https])}\z/, allow_blank: true

  enum responsable: [ :responsable, :fait_de_course, :autre ]

  def self.ransackable_attributes(auth_object = nil)
    ["commentaire", "created_at", "decision", "demandeur_id", "description", "event_id", "id", "implique_id", "lien", "penalite", "penalite_temps", "reglement_id", "updated_at"]
  end
  
end
