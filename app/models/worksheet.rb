class Worksheet < ActiveRecord::Base
  include MathHotSpotErrors
  has_many :worksheet_problems, :order => :problem_number
  has_many :math_problems, :through => :worksheet_problems
  
  def problem_groups
    groups = []
    worksheet_problems.chunk {|prob| prob.instruction }.each { |instruction, group| groups << group }
    groups
  end
  
  def replace_problem(problem_number)
    begin
      raise ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR if problem_number_missing_from_worksheet?(problem_number)
      problem_to_replace = find_math_problem_number(problem_number)
      similar_worksheet_problems = similar_problems_on_worksheet(problem problem_number)
      math_problems_to_exclude = similar_worksheet_problems.map {|wp| wp.math_problem }
      new_problem = MathProblemTemplate.find_replacement(problem_to_replace, { :exclude => math_problems_to_exclude })
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
    
  def similar_problems_on_worksheet(worksheet_problem)
    worksheet_problems.select {|wp| (wp.problem_type == worksheet_problem.problem_type && wp != worksheet_problem) } || []
  end    

  def problem_number_missing_from_worksheet?(problem_number)
    problem_number > worksheet_problems.size
  end
  
  def problem(number)
    worksheet_problems[number - 1]
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
