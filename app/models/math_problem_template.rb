class MathProblemTemplate < ActiveRecord::Base
  include MathHotSpotErrors
  belongs_to :lesson
  belongs_to :instruction
  has_many :problem_levels
  has_many :math_problems, :through => :problem_levels

  accepts_nested_attributes_for :problem_levels
  before_validation :initialize_problem_levels, :on => :create

  # required if we want nested_attributes AND validation of this parent in problem_level
  def initialize_problem_levels
    problem_levels.each { |pl| pl.math_problem_template = self }
  end  
  
  def demo_problem
    level = problem_levels.first
    level.demo_problem
  end

  def problem_count
    total = 0
    problem_levels.each do |level|
      total += level.math_problems.size
    end
    total
  end
  
  def level_count
    problem_levels.size
  end
  
  def self.find_replacement(math_problem, options = {})
    available_problems = MathProblem.find_all_by_math_problem_template_id(math_problem.math_problem_template.id)

    if available_problems.empty?
      raise ActiveRecord::RecordNotFound
    end
    
      # then problem is irreplaceable -- it's one of a kind
    raise ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR if (available_problems.count == 1)
  
    if options[:exclude]
      available_problems.reject! {|problem| options[:exclude].include? problem }
    end
        
    without_original = available_problems.delete_if {|problem| problem == math_problem}
    
    if without_original.empty?
      raise ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING
    end
    
    without_original[rand(without_original.size)]
  end

end
