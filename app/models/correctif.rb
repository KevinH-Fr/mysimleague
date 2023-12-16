class Correctif < ApplicationRecord
  belongs_to :base_setup
  belongs_to :setup, optional: true
  belongs_to :problem
  belongs_to :problem_second

end
