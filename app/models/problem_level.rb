class ProblemLevel < ActiveRecord::Base
  belongs_to :math_problem_template
  has_many :math_problems
  
  validates_presence_of :math_problem_template 

  def demo_problem
    math_problems.first
  end
  
  def display_mode?
    math_problem_template.nil? ? true : math_problem_template.display_mode?
  end

  def instruction
    math_problem_template.instruction
  end
end
