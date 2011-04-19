class MathProblem < ActiveRecord::Base
  include MathHotSpotErrors
  
  has_many :worksheets, :through => :worksheet_problems
  belongs_to :math_problem_template
  has_one :instruction, :through => :math_problem_template
  before_validation :strip_excess_tags
  
  def self.grouped_problems
    where("math_problem_template_id").order("math_problem_template_id")
  end
  
  def self.rogue_problems
    where("math_problem_template_id" => nil)
  end

  def problem_type
    math_problem_template
  end
    
  def display_mode?
    math_problem_template.nil? ? true: math_problem_template.display_mode
  end

  def self.group_all_by_template()
    @problem_groups = []
    probs = grouped_problems.chunk {|prob| prob.math_problem_template }.each {|template, cur_group| @problem_groups << cur_group }
    @problem_groups
  end
  
  def find_replacement(options = {})
    available_problems = MathProblem.find_all_by_math_problem_template_id(self.math_problem_template.id)

    if available_problems.empty?
      raise ActiveRecord::RecordNotFound
    end
    
      # then problem is irreplaceable -- it's one of a kind
    raise ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR if (available_problems.count == 1)
  
    if options[:exclude]
      available_problems.reject! {|problem| options[:exclude].include? problem }
    end
        
    without_original = available_problems.delete_if {|problem| problem == self}
    
    if without_original.empty?
      raise ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING
    end
    
    without_original[rand(without_original.size)]
  end  
  
  private
  
  def strip_excess_tags
    question_markup.gsub!(/\n/,"")
    question_markup.gsub!(/<\/?semantics>|<annotation.*annotation>/,"")
    question_markup.gsub!(/>\s*</,"><")
    question_markup.strip!
  end
     
end