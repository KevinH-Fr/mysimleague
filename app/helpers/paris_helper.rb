module ParisHelper

  def verif_delai_pari(event)
    event = Event.find(event)
    horaire = event.horaire
    time_difference = Time.now - horaire
    hours_difference = time_difference / 3600
    allowed_hours = 0.5
  
    if hours_difference <= allowed_hours
      true # The time difference is within the allowed limit
    else
      false # The time difference has exceeded the allowed limitt
    end
  end

  def verif_user_pari(user, parieur)
    if user.id == parieur 
      true
    end
  end


  def update_paris_resultats(event, association_user, qualification, course, dns)
    paris = Pari.where(event_id: event, association_user_id: association_user)

    # Victoire
    parisVictoire = paris.where(typepari: "victoire")
    resultat_pari = (course == 1) ? "true" : "false"

    parisVictoire.each do |pari|
      pari.update(resultat: resultat_pari)
    end

    # Pole
    parisPole = paris.where(typepari: "pole")
    resultat_pari = (qualification == 1) ? "true" : "false"

    parisPole.each do |pari|
      pari.update(resultat: resultat_pari)
    end

    # Podium
    parisPodium = paris.where(typepari: "podium")
    resultat_pari = (course <= 3) ? "true" : "false"

    parisPodium.each do |pari|
      pari.update(resultat: resultat_pari)
    end

    # Top10
    parisTop10 = paris.where(typepari: "top10")
    resultat_pari = (course <= 10) ? "true" : "false"

    parisTop10.each do |pari|
      pari.update(resultat: resultat_pari)
    end

    #ajouter methode pour rembourser pari si resultat = dns 
    if dns == true
      paris = Pari.where(event_id: event, association_user_id: association_user)
      paris.each do |pari|
        pari.update(resultat: "dns")
      end
    end

    
  
  end

  def false_paris_resultats(event, association_user)
      paris = Pari.where(event_id: event, association_user_id: association_user)
  
      paris.each do |pari|
        pari.update(resultat: "false")
      end
  end



end
  