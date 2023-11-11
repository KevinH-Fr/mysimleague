class Rivalite < ApplicationRecord
  belongs_to :division
  belongs_to :pilote1, class_name: 'AssociationUser'
  belongs_to :pilote2, class_name: 'AssociationUser'
end
