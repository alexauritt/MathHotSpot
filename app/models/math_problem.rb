class MathProblem < ActiveRecord::Base
  has_and_belongs_to_many :worksheets
  belongs_to :math_problem_template
end