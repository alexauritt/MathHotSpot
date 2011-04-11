class MathProblem < ActiveRecord::Base
  has_many :worksheets, :through => :worksheet_problems
  belongs_to :math_problem_template
  has_one :instruction, :through => :math_problem_template
  before_validation :strip_excess_tags
  
  def self.grouped_problems
    where("math_problem_template_id").order("math_problem_template_id")
  end
  
  def self.rougue_problems
    where("math_problem_template_id" => nil)
  end
    
  def display_mode?
    math_problem_template.nil? ? true: math_problem_template.display_mode
  end

  def self.group_all_by_template()
    @problem_groups = []
    probs = grouped_problems.chunk {|prob| prob.math_problem_template }.each {|template, cur_group| @problem_groups << cur_group }
    @problem_groups
  end
  
  private
  
  def strip_excess_tags
    question_markup.gsub!(/\n/,"")
    question_markup.gsub!(/<\/?math[^>]*>|<\/?semantics>|<annotation.*annotation>/,"")
    question_markup.gsub!(/>\s*</,"><")
    question_markup.strip!
  end
     
end