class ParametreSetup < ApplicationRecord
  belongs_to :setup
  belongs_to :base_setup

 # validates :val_parametre, presence: true

 validate :validate_val_parametre_range, on: :update

  def formatted_val
    if base_setup.number_format == 'entiers' || nil
      val_parametre.to_i
    else
      val_parametre
    end
  end

  def format_step
    if base_setup.number_format == 'entiers' || nil
      1
    else
      0.1
    end
  end

  private

  def validate_val_parametre_range
    return unless val_parametre && base_setup

    unless val_parametre.between?(base_setup.val_min, base_setup.val_max)
      errors.add(:val_parametre, "must be within the range of val_min and val_max of base_setup")
    end
  end

end
