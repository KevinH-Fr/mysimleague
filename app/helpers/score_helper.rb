module ScoreHelper
  def categorie_performances_with_details(setup)
    comportements_and_details = []

    Comportement.where(principal: true).each do |comportement|
      details = calculate_categorie_performance_with_details(setup, comportement.nom)
      comportements_and_details << { category: comportement.label_categorie, details: details, average_score: calculate_average_score(details) }
    end

    comportements_and_details
  end

  private

  def calculate_categorie_performance_with_details(setup, categorie)
    @setup = setup
    @categorie = categorie

    #puts "_______________categorie #{@categorie}"
    comportements_retenus = Comportement.where(nom: @categorie).ids
   # puts "___liste comportement: #{comportements_retenus}"
    comportement_influenceurs = ComportementBaseSetup.where(comportement_id: comportements_retenus)

    details = []
    total_score = 0

    comportement_influenceurs.each do |comportement_influenceur|
      details_entry = calculate_comportement_influenceur_details(comportement_influenceur)
      details << details_entry
      total_score += details_entry[:score]
    end

   # puts "Total Score for #{@categorie}: #{total_score}"

    details
  end

  def calculate_comportement_influenceur_details(comportement_influenceur)
    result = {}
  
    # definir val optimale et pire en fonction du sens monter descente
    valOptimale, valPire = if comportement_influenceur.sens == "monter"
                             [comportement_influenceur.base_setup.val_max, comportement_influenceur.base_setup.val_min]
                           else
                             [comportement_influenceur.base_setup.val_min, comportement_influenceur.base_setup.val_max]
                           end
  
    coefBase100 = valOptimale != 0 ? 100 / valOptimale : 100 / valPire
  
    result[:base_setup] = comportement_influenceur.base_setup.parametre
  
    if (parametre_setup = @setup.parametre_setups.find_by(base_setup: comportement_influenceur.base_setup))
      valSetup = parametre_setup.val_parametre
    
      if parametre_setup.filled != true
        result[:score] = 0
      else
        score = if comportement_influenceur.sens == "monter"
                  puts "____call calcul monter_____________"
                 100 - (valOptimale - valSetup) * coefBase100
                else

                  if valOptimale == valSetup 
                    100 
                  else
                    (valPire - valSetup) * coefBase100 
                  end
                  
                end
    
      #   puts "______________  #{result[:base_setup]} ___ val opti #{valOptimale} ___ val courante #{valSetup} ___ coef #{coefBase100} _____score #{score}"
    
        result[:score] = score.to_i
      end
    else
      result[:score] = 0
    end
      
    result
  end
  

  def calculate_average_score(details)
    return 0.0 if details.empty?
  
    total_score = details.sum { |entry| entry[:score] }
    total_score / details.length.to_f
  end


  def synthese_performance_data(setup)
    data = []

    categorie_performances_with_details(setup).each do |comportement_details|
      data << { category: comportement_details[:category], score: calculate_average_score(comportement_details[:details]).to_i }
    end

    data.to_json
  end
  
  def compare_scores(initial_score, updated_score)
    initial_score_array = JSON.parse(initial_score)
    updated_score_array = JSON.parse(updated_score)
  
    comparison_result = []
  
    initial_score_array.each do |initial_entry|
      category = initial_entry['category']
      initial_value = initial_entry['score']
      updated_value = updated_score_array.find { |updated_entry| updated_entry['category'] == category }['score']
  
      comparison_result << {
        'category' => category,
        'initial_score' => initial_value,
        'updated_score' => updated_value,
        'difference' => updated_value - initial_value
      }
    end
  
    comparison_result
  end

  
end
