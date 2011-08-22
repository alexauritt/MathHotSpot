class Worksheet < ActiveRecord::Base
  include MathHotSpotErrors
  has_many :worksheet_problems, :order => :problem_number
  has_many :math_problems, :through => :worksheet_problems
  
  validate :problems_must_be_sequentially_numbered
  
  def renumber_worksheet_problems!
    worksheet_problems.reload
    if worksheet_problems.last.problem_number != worksheet_problems.count
      prev_index = 0
      worksheet_problems.each do |wp|
        next_index = prev_index + 1
        unless wp.problem_number == next_index
          wp.problem_number = next_index
          wp.save
        end
        prev_index += 1
      end
    end
  end
  
  def problem_groups
    groups = []
    worksheet_problems.chunk {|prob| prob.instruction }.each { |instruction, group| groups << group }
    groups
  end
  
  def replace_problem(problem_number)
    begin
      raise ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR if problem_number_missing_from_worksheet?(problem_number)
      target_worksheet_problem = problem problem_number
      similar_worksheet_problems = similar_problems_on_worksheet target_worksheet_problem
      target_worksheet_problem.replace_math_problem({ :exclude => similar_worksheet_problems })
      true
    rescue ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING,
      ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR, 
      ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR => bam
      errors[:replace_failure] << bam
      false
    end
  end
  
  def error_for_failed_replace
    Message.display(errors[:replace_failure].first) || MathHotSpotErrors::Message::DEFAULT
  end
  
  def problem(number)
    worksheet_problems[number - 1]
  end  
  
  def problems_sequentially_numbered?
    problem_numbers = worksheet_problems.map {|wp| wp.problem_number }
    problem_numbers.sort!
    worksheet_problems.empty? || (problem_numbers == Array(1..worksheet_problems.count))
  end
  
  private

  def problems_must_be_sequentially_numbered
    errors.add(:worksheet_problems, "must be consecutive integers beginning with 1") unless problems_sequentially_numbered?
  end
    
  def similar_problems_on_worksheet(worksheet_problem)
    worksheet_problems.select {|wp| (wp.problem_level == worksheet_problem.problem_level && wp != worksheet_problem) } || []
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
