class MathProblem < ActiveRecord::Base
  has_many :worksheets, :through => :worksheet_problems
  belongs_to :math_problem_template
  has_one :instruction, :through => :math_problem_template
    
  def display_mode?
    math_problem_template.display_mode
  end
   
end