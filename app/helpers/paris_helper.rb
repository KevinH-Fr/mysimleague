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

    puts "_____________call update pari helper paris "
    paris = Pari.where(event_id: event, association_user_id: association_user)

    # Victoire
    parisVictoire = paris.where(typepari: "victoire")
    resultat_pari = (course == 1) ? "true" : "false"

    parisVictoire.each do |pari|
      pari.update(resultat: resultat_pari)
      puts "_____pari victoire updated - id pari: #{pari.id} - coureur: #{pari.association_user.user.nom} - resultat pari: #{pari.resultat}"
    end

    # Pole
    parisPole = paris.where(typepari: "pole")
    resultat_pari = (qualification == 1) ? "true" : "false"

    parisPole.each do |pari|
      pari.update(resultat: resultat_pari)
      puts "_____pari pole updated - id pari: #{pari.id} - coureur: #{pari.association_user.user.nom} - resultat pari: #{pari.resultat}"

    end

    # Podium
    parisPodium = paris.where(typepari: "podium")
    resultat_pari = (course <= 3) ? "true" : "false"

    parisPodium.each do |pari|
      pari.update(resultat: resultat_pari)
      puts "_____pari podium updated - id pari: #{pari.id} - coureur: #{pari.association_user.user.nom} - resultat pari: #{pari.resultat}"

    end

    # Top10
    parisTop10 = paris.where(typepari: "top10")
    resultat_pari = (course <= 10) ? "true" : "false"

    parisTop10.each do |pari|
      pari.update(resultat: resultat_pari)
      puts "_____pari top10 updated - id pari: #{pari.id} - coureur: #{pari.association_user.user.nom} - resultat pari: #{pari.resultat}"

    end

    #ajouter methode pour rembourser pari si resultat = dns 
    if dns == true
      paris = Pari.where(event_id: event, association_user_id: association_user)
      paris.each do |pari|
        pari.update(resultat: "dns")
        puts "_____pari dns updated - id pari: #{pari.id} - coureur: #{pari.association_user.user.nom} - resultat pari: #{pari.resultat}"

      end
    end

  end

  def false_paris_resultats(event, association_user)
      paris = Pari.where(event_id: event, association_user_id: association_user)
  
      paris.each do |pari|
        pari.update(resultat: "false")
        puts "_____pari false updated - id pari: #{pari.id} - coureur: #{pari.association_user.user.nom} - resultat pari: #{pari.resultat}"

      end
  end



end
  