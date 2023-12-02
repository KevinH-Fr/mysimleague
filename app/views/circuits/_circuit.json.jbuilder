json.extract! circuit, :id, :nom, :pays, :carte, :latitude, :longitude, :created_at, :updated_at
json.url circuit_url(circuit, format: :json)
