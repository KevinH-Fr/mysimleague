class Pari < ApplicationRecord

  include ParieursHelper
  include ScoringHelper
  
  belongs_to :event
  belongs_to :user
  belongs_to :association_user

  validate :verif_montant, on: :create

  validates :montant, numericality: { greater_than: 0 }

  before_create :calcul_solde
  before_update :calcul_solde

  after_create :increment_user_scoring_paris
  after_create :update_user_solde_paris
  after_update :update_user_solde_paris


  def feed_content
    id
  end 

  def self.recent(limit = 5)
    order(created_at: :desc).limit(limit)
  end

  def calcul_solde  
    if self.resultat == "true"
      self.solde = self.montant * self.cote
    elsif self.resultat == "dns"
      self.solde = self.montant
    else
      self.solde = 0 #-self.montant
    end
  end 

  private

# def update_solde
 #   if resultat == true
 #     self.solde = cote.to_f * montant
 #   end
 #end

 def verif_montant

  user = self.user_id 
  if user 
    soldeAvant = somme_paris_user(Time.now.year, [User.find(user)])[User.find(user).id][:sum]

    total = soldeAvant.to_f - montant.to_f
    if total < 0 
      errors.add(:base, "Pari impossible - Insufficient balance - solde disponible: #{soldeAvant}")
    else 
    end
  end
  
 end

 def self.ransackable_attributes(auth_object = nil)
  ["association_user_id", "cote", "created_at", "event_id", "id", "montant", "resultat", "solde", "typepari", "updated_at", "user_id"]
 end


 def increment_user_scoring_paris
    user.increment!(:paris_score, 1)
 end

 def update_user_solde_paris
   user.solde_paris = solde_paris(created_at.year, user)    
   user.save
 end

end
