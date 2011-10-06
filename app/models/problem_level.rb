class ProblemLevel < ActiveRecord::Base

  belongs_to :problem_type

  has_many :math_problems, :inverse_of => :problem_level
  has_one :lesson, :through => :problem_type
  
  validates_presence_of :level_number
  validates_uniqueness_of :level_number, :scope => [:problem_type_id]
  validate :problem_type_exists
  
  accepts_nested_attributes_for :math_problems, :reject_if => lambda { |a| a[:question_markup].blank? || a[:answer_markup].blank? }, :allow_destroy => true

  before_validation :assign_unowned_problems_to_problem_type_owner!
  before_destroy :empty?
  
  def to_param
    level_number.to_s
  end

  def problem_count
    math_problems.size
  end

  def empty?
    math_problems.empty?
  end
  
  def problem_type_title
    problem_type.title
  end

  def demo_problem
    math_problems.first
  end
  
  def display_mode?
    problem_type.nil? ? true : problem_type.display_mode?
  end

  def instruction
    problem_type.instruction
  end

  def instruction_text
    instruction.nil? ? MathHotSpotErrors::Message::NO_INSTRUCTIONS : problem_type.instruction_text
  end
  
  def owner
    problem_type.owner
  end
  
  private
  def assign_unowned_problems_to_problem_type_owner!
    math_problems.each do |mp|
      mp.owner ||= problem_type.owner
    end
  end
  
  def problem_type_exists
    begin
      errors.add(:problem_type_id, "doesn't exist") unless (!problem_type.nil? || (problem_type_id && ProblemType.exists?(problem_type_id)))
    rescue
      errors.add(:problem_type_id, "not found in db")
    end
  end
end
