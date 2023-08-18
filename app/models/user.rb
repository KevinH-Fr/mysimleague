class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :association_users, dependent: :destroy

  has_many :ligues, dependent: :destroy

  validates :nom, presence: true


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
   
end
