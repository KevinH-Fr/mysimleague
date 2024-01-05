module ParieursUpdateHelper
    include ParieursHelper
 
    def update_solde_parieurs()
        users = User.all 

        users.each do |user|
            solde_paris = solde_paris(user)
            user.update(solde_paris: solde_paris)
        end

    end

end 
