class Pari < ApplicationRecord

  include ParieursHelper
  
  belongs_to :event
  belongs_to :user
  belongs_to :association_user

  validate :verif_montant

  
  #before_save :update_solde, if: :resultat_changed?
  before_save :calcul_solde
  
  def feed_content
    id
  end 

  def calcul_solde  
    puts "_________________________________________call calcul solde depuis model pari"
    if self.resultat == true 
      self.solde = self.montant * self.cote
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
    puts "____________test val user depuis verif montant: #{user}"
    soldeAvant = somme_paris_user(Time.now.year, [User.find(user)])[User.find(user).id][:sum]

    puts " ____________solde avant depuis verif montant: #{soldeAvant}"

    total = soldeAvant.to_f - montant.to_f
    if total < 0 
      errors.add(:base, "Pari impossible - Insufficient balance - solde disponible: #{soldeAvant}")
      puts " ------------ Pari Impossible - total: #{total}"
    else 
      puts " ------------ Pari Possible - total: #{total}"
    end
  end
  
 end

 def self.ransackable_attributes(auth_object = nil)
  ["association_user_id", "cote", "created_at", "event_id", "id", "montant", "resultat", "solde", "typepari", "updated_at", "user_id"]
 end

end
