class Lesson < ActiveRecord::Base
  belongs_to :subject
  has_many :math_problem_templates
end
