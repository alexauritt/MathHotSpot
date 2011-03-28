class MathProblemTemplate < ActiveRecord::Base
  include MathHotSpotErrors
  belongs_to :lesson
  belongs_to :instructions
  has_many :math_problems
  
  def self.find_replacement(math_problem, options = {})
    available_problems = MathProblem.find_all_by_math_problem_template_id(math_problem.math_problem_template.id)

    if available_problems.empty?
      raise ActiveRecord::RecordNotFound
    end
    
    if (available_problems.count == 1)  # then problem is irreplaceable -- it's one of a kind
      raise ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR
    end
  
    if options[:exclude]
      available_problems.reject! {|problem| options[:exclude].include? problem.id }
    end
        
    without_original = available_problems.delete_if {|problem| problem == math_problem}
    
    raise ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING if without_original.empty? 
    
    without_original[rand(without_original.size)]
  end
end
