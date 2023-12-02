json.extract! reglement, :id, :ligue_id, :num_article, :titre_article, :contenu_article, :penalite, :penalite_temps, :created_at, :updated_at
json.url reglement_url(reglement, format: :json)
