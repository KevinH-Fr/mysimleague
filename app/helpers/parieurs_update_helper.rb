module ParieursUpdateHelper
    include ParieursHelper
 
    def update_solde_parieurs(annee)
        users = User.all 

        users.each do |user|
            solde_paris = solde_paris(annee, user)
            user.update(solde_paris: solde_paris)
        end

    end

end 
