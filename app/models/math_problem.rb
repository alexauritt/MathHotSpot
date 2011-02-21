class MathProblem < ActiveRecord::Base
  has_many :worksheets, :through => :worksheet_problems
  belongs_to :math_problem_template
end