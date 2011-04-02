class Worksheet < ActiveRecord::Base
  include MathHotSpotErrors
  has_many :worksheet_problems, :order => :problem_number
  has_many :math_problems, :through => :worksheet_problems

  def replace_problem(problem_number)
    begin
      raise ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR if problem_number_missing_from_worksheet?(problem_number)
      problem_to_replace = find_math_problem_number(problem_number)
      similar_problem_ids = ids_of_similar_problems_on_worksheet(problem_to_replace)
      new_problem = MathProblemTemplate.find_replacement(problem_to_replace, { :exclude => similar_problem_ids })
      if new_problem == problem_to_replace
        raise ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR
      else 
        replace_math_problem_number(problem_number, new_problem)
      end 
      true
    rescue ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING, ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR, ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR => bam
      errors[:replace_failure] << bam
      false
    end
  end
  
  def error_for_failed_replace
    Message.display(errors[:replace_failure].first) || MathHotSpotErrors::Message::DEFAULT
  end
  
  private
    
  def ids_of_similar_problems_on_worksheet(problem)
    similar_problems = math_problems.select {|prob| ((prob.math_problem_template == problem.math_problem_template) && (prob != problem)) }
    similar_problems.map {|prob| prob.id }
  end
  
  def problem_number_missing_from_worksheet?(problem_number)
    problem_number > worksheet_problems.size
  end
  
  def find_math_problem_number(problem_number)
    worksheet_problems[problem_number - 1].math_problem
  end
  
  def replace_math_problem_number(problem_number, replacement_problem)
    worksheet_problem = self.worksheet_problems[problem_number - 1]
    worksheet_problem.math_problem = replacement_problem
    worksheet_problem.save
  end
end
