class Instruction < ActiveRecord::Base
  has_many :math_problem_templates
  validates_presence_of :description
end
