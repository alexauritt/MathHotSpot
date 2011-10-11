  class Worksheet < ActiveRecord::Base
  include MathHotSpotErrors
  include RightRabbitErrors
  
  belongs_to :owner, :class_name => "User"  
  has_many :worksheet_problems, :order => "position", :dependent => :destroy
  has_many :math_problems, :through => :worksheet_problems
  
  accepts_nested_attributes_for :worksheet_problems, :reject_if => lambda { |wp| wp[:math_problem_id].blank?}, :allow_destroy => true

  validates_presence_of :owner_id, :title
  validates_associated :owner
  validates_uniqueness_of :title, :score => :owner_id
  
  before_validation :initialize_worksheet_problems
    
  def problem_count
    worksheet_problems.size
  end
  
  def problem_types
    math_problems.map {|mp| mp.problem_type }.uniq.compact
  end
  
  def unclassified_problems
    math_problems.reject { |mp| mp.classified? }
  end
  
  def next_available_problem_number
    problem_count + 1
  end
  
  def problem_exists?(problem_number)
    !(problem problem_number).nil?
  end
  
  def problem_classified?(problem_number)
    problem_exists?(problem_number) ? problem(problem_number).classified? : false
  end
    
  def empty?
    problem_count == 0
  end
    
  def problem_groups
    groups = []
    worksheet_problems.chunk {|prob| prob.instruction }.each { |instruction, group| groups << group }
    groups
  end
  
  def replace_problem(problem_number)
    begin
      raise ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR unless problem_exists?(problem_number)
      raise ProblemReplacementErrors::ATTEMPT_TO_REPLACE_UNCLASSFIED_PROBLEM_ERROR unless problem_classified?(problem_number)
      target_worksheet_problem = problem problem_number
      similar_worksheet_problems = similar_problems_on_worksheet target_worksheet_problem
      target_worksheet_problem.replace_math_problem({ :exclude => similar_worksheet_problems })
      target_worksheet_problem
    rescue ProblemReplacementErrors::ATTEMPT_TO_REPLACE_UNCLASSFIED_PROBLEM_ERROR => e
      Rails.logger.error "worksheet.replace_problem called for unclassified problem number."
      errors[:replace_failure] << e
      nil
    rescue NoSimilarProblemsRemainingError,
      UniqueProblemError, 
      ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR => bam
      errors[:replace_failure] << bam
      nil
    end
  end
  
  def add_problem_like!(number)
    begin
      unless problem_exists? number
        errors[:base] << WorksheetModifierErrors::Messages::PROBLEM_NUMBER_MISSING_FOR_ADD_LIKE
        return nil
      end
            
      unless problem_classified? number
        Rails.logger.error WorksheetModifierErrors::Messages::PROBLEM_NUMBER_UNCLASSIFIED_FOR_ADD_LIKE
        errors[:base] << WorksheetModifierErrors::Messages::PROBLEM_NUMBER_UNCLASSIFIED_FOR_ADD_LIKE
        return nil
      end
    
      target_worksheet_problem = problem number
      target_math_problem = target_worksheet_problem.math_problem
      similar_worksheet_problems = similar_problems_on_worksheet target_worksheet_problem

      new_math_problem = target_math_problem.find_problem_from_same_level({:exclude => similar_worksheet_problems.map {|wp| wp.math_problem}})
    
      new_worksheet_problem = worksheet_problems.create(:problem_number => next_available_problem_number, :math_problem => new_math_problem)
    rescue UniqueProblemError, NoSimilarProblemsRemainingError => e
      errors[:base] << e.message
      nil
    end
  end
  
  def remove_problem(number)
    problem_exists?(number) ? remove_problem_number_and_reload!(number) : false
  end
      
  def error_for_failed_replace
    Message.display(errors[:replace_failure].first) || errors[:replace_failure].first.message || MathHotSpotErrors::Message::DEFAULT
  end
  
  def problem(number)
    worksheet_problems[number - 1]
  end  
    
  def similar_problems_on_worksheet(worksheet_problem)
    worksheet_problems.select {|wp| (wp.problem_level == worksheet_problem.problem_level && wp != worksheet_problem) } || []
  end  
    
  private

  def initialize_worksheet_problems
    worksheet_problems.each { |wp| wp.worksheet = self }    
  end
      
  def find_math_problem_number(problem_number)
    worksheet_problems[problem_number - 1].math_problem
  end
  
  def replace_math_problem_number(problem_number, replacement_problem)
    worksheet_problem = self.worksheet_problems[problem_number - 1]
    worksheet_problem.math_problem = replacement_problem
    worksheet_problem.save
  end
  
  def remove_problem_number_and_reload!(problem_number)
    worksheet_problem = problem problem_number
    worksheet_problem.destroy
    reload
  end
end
