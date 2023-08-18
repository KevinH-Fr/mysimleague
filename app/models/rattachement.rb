class Rattachement < ApplicationRecord
  belongs_to :user
  belongs_to :ligue

  has_one :association_user
  accepts_nested_attributes_for :association_user
   
end
