module SetupsHelper
    def categorie_title(title)
        content_tag(:span, title, class: 'fw-bold')
    end

    def label_value_content(label, content)
        content_tag(:span, "#{label}: #{content}", class: 'badge bg-secondary')
    end

    def verif_user_setup(user, user_setup)
        if user.id == user_setup 
          true
        end
    end

    def initial_score_json
        result_array = SetupsInitialScore.where(setup_id: @setup.id).map do |initial_setup|
          {
            "category": initial_setup.comportement.label_categorie,
            "score": initial_setup.initial_score
          }
        end 
        result_array.to_json
    end
  
    
end
