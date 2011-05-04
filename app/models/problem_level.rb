class ProblemLevel < ActiveRecord::Base
  belongs_to :problem_type
  has_many :math_problems
  has_one :lesson, :through => :problem_type
  
  validates_presence_of :problem_type
  
  accepts_nested_attributes_for :math_problems

  def problem_count
    math_problems.size
  end

  def demo_problem
    math_problems.first
  end
  
  def display_mode?
    problem_type.nil? ? true : problem_type.display_mode?
  end

  def instruction
    problem_type.instruction
  end
  
end
