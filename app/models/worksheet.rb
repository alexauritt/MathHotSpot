class Worksheet < ActiveRecord::Base
  has_many :worksheet_problems, :order => :problem_number
  has_many :math_problems, :through => :worksheet_problems

  module Errors
    PROBLEM_NUMBER_MISSING_ERROR = "Attempt to replace a problem number which is missing from the current worksheet."
    UNIQUE_PROBLEM_REPLACE_ERROR = "Attempt to replace an irreplaceable math problem."
  end

  def replace_problem(problem_number)
    
    if problem_number_missing_from_worksheet? problem_number
      errors[:replace_failure] << Errors::PROBLEM_NUMBER_MISSING_ERROR
      return false
    else
      problem_to_replace = find_math_problem_number(problem_number)
      new_problem = MathProblemTemplate.find_replacement(problem_to_replace)
      if new_problem == problem_to_replace
        errors[:replace_failure] << Errors::UNIQUE_PROBLEM_REPLACE_ERROR
      else 
        replace_math_problem_number(problem_number, new_problem)
      end
      
      true
    end
    
  end
  
  def error_for_failed_replace
    errors[:replace_failure].first || "Failed to replace the problem for unknown reason."
  end
  
  private
  
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
