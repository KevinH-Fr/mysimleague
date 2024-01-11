class Resultat < ApplicationRecord

  include ScoringHelper
  include UsersHelper
  include ParieursHelper
  include ParisHelper

  belongs_to :event
  belongs_to :association_user
  belongs_to :equipe

  attribute :score, :integer, default: 0

  after_save :update_user_paris

  after_commit :update_user_solde_paris

  
  def feed_content
    id
  end 
   
  def self.ransackable_attributes(auth_object = nil)
    ["association_user_id", "course", "created_at", "dnf", "dns", "dotd", "equipe_id", "event_id", "id", "mt", "qualification", "qualification_sprint", "score", "updated_at"]
  end

  def update_user_paris 
    update_paris_resultats(
    event_id, 
    association_user_id, 
    qualification.to_i, 
    course.to_i,
    dns
  )
  end 

  def update_user_solde_paris

    paris_for_resultat = Pari.where(event_id: event_id, association_user_id: association_user_id)
    users_with_paris = paris_for_resultat.includes(:user).map(&:user).uniq

    users_with_paris.each do |user|
    #  user.update(solde_paris:  solde_paris(annees_paris.last, user))
       user.update(solde_paris:  solde_paris(user))

    end
    
  end


end
