class Worksheet < ActiveRecord::Base
  include MathHotSpotErrors
  
  belongs_to :owner, :class_name => "User"  
  has_many :worksheet_problems, :order => :problem_number, :dependent => :destroy
  has_many :math_problems, :through => :worksheet_problems
  
  accepts_nested_attributes_for :worksheet_problems, :reject_if => lambda { |wp| wp[:problem_number].blank? || wp[:math_problem_id].blank?}, :allow_destroy => true

  before_validation :renumber_worksheet_problems!, :initialize_worksheet_problems

  validates_presence_of :owner_id, :title
  validates_associated :owner
  validates_uniqueness_of :title, :score => :owner_id
  validate :problems_must_be_sequentially_numbered
    
  def problem_count
    worksheet_problems.size
  end
  
  def problem_exists?(problem_number)
    !(problem problem_number).nil?
  end
    
  def empty?
    problem_count == 0
  end
  
  def renumber_worksheet_problems!
    return if worksheet_problems.empty?
    worksheet_problems.reload unless self.new_record?
    if worksheet_problems.last.problem_number != worksheet_problems.count
      prev_index = 0
      worksheet_problems.each do |wp|
        next_index = prev_index + 1
        unless wp.problem_number == next_index
          wp.problem_number = next_index
          wp.save unless self.new_record?
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
      raise ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR unless problem_exists?(problem_number)
      target_worksheet_problem = problem problem_number
      similar_worksheet_problems = similar_problems_on_worksheet target_worksheet_problem
      target_worksheet_problem.replace_math_problem({ :exclude => similar_worksheet_problems })
      target_worksheet_problem
    rescue ProblemReplacementErrors::NO_SIMILAR_PROBLEMS_REMAINING,
      ProblemReplacementErrors::UNIQUE_PROBLEM_REPLACE_ERROR, 
      ProblemReplacementErrors::PROBLEM_NUMBER_MISSING_ERROR => bam
      errors[:replace_failure] << bam
      nil
    end
  end
  
  def add_problem_like!(number)
    unless problem_exists? number
      errors[:base] << WorksheetModifierErrors::Messages::PROBLEM_NUMBER_MISSING_FOR_ADD_LIKE
      return nil
    end
    
    target_worksheet_problem = problem number
    target_math_problem = target_worksheet_problem.math_problem
    similar_worksheet_problems = similar_problems_on_worksheet target_worksheet_problem

    new_math_problem = target_math_problem.find_problem_from_same_level({:exclude => similar_worksheet_problems.map {|wp| wp.math_problem}})
    
    new_worksheet_problem = worksheet_problems.create(:problem_number => (self.problem_count + 1), :math_problem => new_math_problem)
  end
  
  def remove_problem(number)
    problem_exists?(number) ? remove_problem_number_and_reload!(number) : false
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
    worksheet_problems.empty? || (problem_numbers == Array(1..worksheet_problems.size))
  end
    
  private

  def initialize_worksheet_problems
    worksheet_problems.each { |wp| wp.worksheet = self }    
  end

  def problems_must_be_sequentially_numbered
    errors.add(:worksheet_problems, "must be consecutive integers beginning with 1") unless problems_sequentially_numbered?
  end
    
  def similar_problems_on_worksheet(worksheet_problem)
    worksheet_problems.select {|wp| (wp.problem_level == worksheet_problem.problem_level && wp != worksheet_problem) } || []
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
    (problem problem_number).destroy
    reload
  end
end
