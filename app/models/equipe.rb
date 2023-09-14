class Equipe < ApplicationRecord

    has_many :resultats, dependent: :destroy

    has_one_attached :voiture
    has_one_attached :logo
    has_one_attached :banniere

    validate :medias_format_and_size

    def feed_content
        id
    end 

    def medias_format_and_size
      %w(logo banniere voiture).each do |media|
          if send(media).attached?
              unless send(media).blob.content_type.in?(%w(image/jpeg image/png image/gif image/avif image/webp))
                  errors.add(media.to_sym, 'must be a JPEG, PNG, GIF, AVIF or WebP image')
              end
              unless send(media).blob.byte_size <= 1.megabytes
                  errors.add(media.to_sym, 'size should be less than 1MB')
              end
          end
      end
    end

    def self.ransackable_attributes(auth_object = nil)
      super + ['logo', 'voiture']
    end

    def self.ransackable_associations(auth_object = nil)
        ["logo_attachment", "logo_blob", "voiture_attachment", "voiture_blob"]
      end

    ActiveStorage::Attachment.class_eval do
      def self.ransackable_attributes(auth_object = nil)
        ['blob_id', 'created_at', 'id', 'name', 'record_id', 'record_type']
      end
    end


    def self.recent(limit = 5)
      order(created_at: :desc).limit(limit)
    end
      
end

