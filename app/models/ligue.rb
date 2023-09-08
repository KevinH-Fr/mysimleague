class Ligue < ApplicationRecord
    has_many :saisons, dependent: :destroy
    has_many :association_admins, dependent: :destroy
    has_many :reglements, dependent: :destroy
    has_many :rattachements, dependent: :destroy

    belongs_to :user

    validates :nom, presence: true
    validate :medias_format_and_size

    has_one_attached :logo

    after_create :create_association_admin

    def feed_content
        id
    end 

    def medias_format_and_size
	    if logo.attached?
	        unless logo.blob.content_type.in?(%w(image/jpeg image/png image/gif))
	            errors.add(:logo, 'must be a JPEG, PNG, or GIF image')
	        end
            unless logo.blob.byte_size <= 1.megabytes
	            errors.add(:logo, 'size should be less than 1MB')
            end
	    end
    end


    private

    def create_association_admin
      AssociationAdmin.create(
        ligue: self, 
        user: self.user,
        actif: true,
        valide: true)
    end

    def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "nom", "points_initial", "updated_at", "user_id"]
    end

    def self.recent(limit = 5)
        order(created_at: :desc).limit(limit)
    end

    def self.ransackable_associations(auth_object = nil)
        ["association_admins", "saisons", "user"]
    end

end
