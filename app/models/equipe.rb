class Equipe < ApplicationRecord

    has_many :resultats, dependent: :destroy

    has_one_attached :voiture
    has_one_attached :logo
    has_one_attached :banniere

    def feed_content
        id
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

