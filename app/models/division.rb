class Division < ApplicationRecord
  belongs_to :saison
  has_many :events, dependent: :destroy
  has_many :association_users, dependent: :destroy
  has_many :rivalites, dependent: :destroy

  validates :nom, presence: true
  validates :saison_id, presence: true

  scope :active, -> { where(archived: [false, nil]) }
  scope :archived, -> { where(archived: true) }

  def feed_content
    id
  end 

end
