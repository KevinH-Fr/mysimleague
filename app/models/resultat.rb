class Resultat < ApplicationRecord

  include ScoringHelper
  include UsersHelper

  belongs_to :event
  belongs_to :association_user
  belongs_to :equipe

  attribute :score, :integer, default: 0

  #after_create :update_pilote_score
  after_create :update_pilote_score
  after_update :update_pilote_score

  
  def feed_content
    id
  end 
   
  def self.ransackable_attributes(auth_object = nil)
    ["association_user_id", "course", "created_at", "dnf", "dns", "dotd", "equipe_id", "event_id", "id", "mt", "qualification", "qualification_sprint", "score", "updated_at"]
  end

  private 


  def update_pilote_score
    user =  association_user.user
    puts "_______________________________________________#{user.id}_________________________________"
    new_score_pilote = scoring_pilote_sum(association_user.user)
    user.score_pilote = 200
    user.save

    puts "_____________________________________________ #{user.score_pilote}____________________________"
  
  end

end
