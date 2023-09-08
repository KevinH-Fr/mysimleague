class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :association_users, dependent: :destroy

  has_many :ligues, dependent: :destroy

  validates :nom, presence: true

  has_one_attached :profile_pic
  validate :profile_pic_format_and_size



  def feed_content
    id
   end 

   def self.ransackable_attributes(auth_object = nil)
    ["admin", "created_at", "email", "encrypted_password", "id", "nom", "pilote", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at", "visiteur"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["association_users", "ligues"]
  end

  def self.recent(limit = 5)
    order(created_at: :desc).limit(limit)
  end

  def profile_pic_format_and_size
    if profile_pic.attached?
      unless profile_pic.blob.content_type.in?(%w(image/jpeg image/png image/gif))
        errors.add(:profile_pic, 'must be a JPEG, PNG, or GIF image')
      end
      unless profile_pic.blob.byte_size <= 1.megabyte
        errors.add(:profile_pic, 'size should be less than 1MB')
      end
    end
  end
   
end
