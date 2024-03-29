class User < ApplicationRecord

  include ActionView::Helpers::TextHelper

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :association_users, dependent: :destroy
  has_many :ligues, dependent: :destroy

  validates :nom, presence: true

  has_one_attached :profile_pic
  validate :profile_pic_format_and_size

  validates :twitch, format: { with: URI::DEFAULT_PARSER.make_regexp },
  allow_blank: true,
  on: :create  # Only validate on record creation

  #ajoutés pour scorgin - verifier ne donne pas d'erreurs sur existant: 
  has_many :paris
  has_many :bonus_paris

  has_many :dotds
  has_many :purchases
  has_many :setups
  
  before_create :initialize_score_pilote
  after_create :update_user_paris

  #after_create do
  #  Stripe::Customer.create(email: email)
  #end


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

  def webp_variant
    if profile_pic.attached?
      begin
        profile_pic.variant(
          format: :webp,
          resize_to_limit: [500, 500],
          saver: {
            subsample_mode: "on",
            strip: true,
            interlace: true,
            lossless: false,
            quality: 80 }).processed
      rescue => e
        Rails.logger.error "Error processing image: #{e.message}"
        '/images/profile_default.webp'
      end
    else
      '/images/profile_default.webp'
    end
  end

  def profile_pic_format_and_size
    if profile_pic.attached?
      unless profile_pic.blob.content_type.in?(%w(image/jpeg image/png image/gif))
        errors.add(:profile_pic, 'must be a JPEG, PNG, or GIF image')
      end
      unless profile_pic.blob.byte_size <= 2.megabyte
        errors.add(:profile_pic, 'size should be less than 2MB')
      end
    end
  end

  def default_profile_pic
    if profile_pic.attached?
      profile_pic
    else
      '/images/profile_default.webp'
    end
  end

  def short_name
    truncate(nom, length: 12)
  end

  def icon_controlleur
    if controlleur_type == "volant"
      ActionController::Base.helpers.image_tag("/images/steering-wheel_white.webp", alt: "Steering Wheel Image", class: "icon-controlleur ms-2")
    elsif controlleur_type == "manette"
      '<i class="fas fa-gamepad fa-xl"></i>'.html_safe
    end
  end


  def update_user_paris
    val_solde_paris = solde_paris_base(Time.now.year) # Provide the user instance as the second argument
    update(solde_paris: val_solde_paris)
  end


  private

  def initialize_score_pilote
    self.score_pilote = 0
  end
  
  def solde_paris_base(annee)
    solde_depart = 500
    credit_semaine = 100
    numero_semaine = Date.today.strftime('%W').to_i
    somme_credit_semaine = credit_semaine * numero_semaine

    start_date = DateTime.new(annee.to_i, 1, 1)
    end_date = DateTime.new(annee.to_i, 12, 31)

    solde = solde_depart.to_i + somme_credit_semaine.to_i
    solde
  end





end
