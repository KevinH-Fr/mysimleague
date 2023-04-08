json.extract! circuit, :id, :nom, :pays, :adresse, :latitude, :longitude, :created_at, :updated_at
json.url circuit_url(circuit, format: :json)
