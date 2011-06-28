class ProblemLevel < ActiveRecord::Base

  belongs_to :problem_type

  has_many :math_problems
  has_one :lesson, :through => :problem_type
  
  validates_presence_of :problem_type, :level_number
  validates_uniqueness_of :level_number, :scope => [:problem_type_id]
  
  accepts_nested_attributes_for :math_problems, :reject_if => lambda { |a| a[:question_markup].blank? || a[:answer_markup].blank? }, :allow_destroy => true

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

  def demo_problem
    math_problems.first
  end
  
  def display_mode?
    problem_type.nil? ? true : problem_type.display_mode?
  end

  def instruction
    problem_type.instruction
  end

end
