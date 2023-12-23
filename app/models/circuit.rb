class Circuit < ApplicationRecord

    include ActionView::Helpers::TextHelper

    validates :nom, presence: true
    validate :medias_format_and_size

    has_one_attached :drapeau

    has_many :events
    

    def feed_content
        id
    end 

    def circuit_nom_complet
        "#{pays} - #{nom}" # Assuming 'nom' is the circuit's name attribute and 'pays' is the country attribute
    end

    def short_name
        truncate(nom, length: 15)
    end

    def self.ransackable_attributes(auth_object = nil)
        ["carte", "created_at", "id", "latitude", "longitude", "nom", "pays", "updated_at"]
    end
	
	def medias_format_and_size
	    if drapeau.attached?
	        unless drapeau.blob.content_type.in?(%w(image/jpeg image/png image/gif image/avif image/webp))
	            errors.add(:drapeau, 'must be a JPEG, PNG, or GIF image')
	        end
            unless drapeau.blob.byte_size <= 1.megabytes
	            errors.add(:drapeau, 'size should be less than 1MB')
            end
	    end
    end

end
