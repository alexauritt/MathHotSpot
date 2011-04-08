class WorksheetProblem < ActiveRecord::Base
  belongs_to :worksheet
  belongs_to :math_problem
  has_one :math_problem_template, :through => :math_problem
  
  validates_presence_of :worksheet, :math_problem
  
  def instruction
    math_problem.instruction
  end
end
