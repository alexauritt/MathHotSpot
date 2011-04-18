class WorksheetProblem < ActiveRecord::Base
  belongs_to :worksheet
  belongs_to :math_problem
  
  validates_presence_of :worksheet, :math_problem


  def problem_type
    math_problem.nil? ? nil : math_problem.problem_type
  end
  
  def instruction
    math_problem.instruction
  end
end
