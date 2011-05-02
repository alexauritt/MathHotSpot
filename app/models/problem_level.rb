class ProblemLevel < ActiveRecord::Base
  belongs_to :math_problem_template
  has_many :math_problems
  has_one :lesson, :through => :math_problem_template
  
  validates_presence_of :math_problem_template
  
  accepts_nested_attributes_for :math_problems

  def problem_count
    math_problems.size
  end

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
