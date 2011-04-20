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
  
  def replace_math_problem(options = {:exclude => []})
    current_problem = self.math_problem
    self.math_problem = current_problem.find_replacement(options)
    save
  end
end
