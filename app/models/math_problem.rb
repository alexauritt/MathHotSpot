class MathProblem < ActiveRecord::Base
  has_many :worksheets, :through => :worksheet_problems
  belongs_to :math_problem_template
  has_one :instruction, :through => :math_problem_template

  def self.group_all_by_template()
    @problem_groups = []
    probs = order("math_problem_template_id").chunk {|prob| prob.math_problem_template }.each {|template, cur_group| @problem_groups << cur_group }
    @problem_groups
  end
    
  def display_mode?
    math_problem_template.display_mode
  end
   
end