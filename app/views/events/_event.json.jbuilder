json.extract! event, :id, :date, :horaire, :numero, :circuit_id, :saison_id, :division_id, :ligue_id, :created_at, :updated_at
json.url event_url(event, format: :json)
