class WorksheetProblem < ActiveRecord::Base
  belongs_to :worksheet
  belongs_to :math_problem
  
  has_one :problem_level, :through => :math_problem
  
  accepts_nested_attributes_for :math_problem
  
  validates_uniqueness_of :problem_number, :scope => :worksheet_id
  validate :worksheet_exists, :math_problem_exists
  after_destroy :renumber_remaining_worksheet_problems!
  
  def problem_level
    math_problem.nil? ? nil : math_problem.problem_level
  end
  
  def level_number
    problem_level.nil? ? nil : problem_level.level_number
  end
  
  def instruction
    math_problem.instruction
  end
  
  def instruction_description
    math_problem.instruction_description
  end
  
  def replace_math_problem(options = {:exclude => []})
    current_problem = self.math_problem
    options[:exclude] = options[:exclude].map { |worksheet_problem| worksheet_problem.math_problem } || []
    self.math_problem = current_problem.find_problem_from_same_level(options)
    save
  end
  
  def replacement_available?
    similars = worksheet.similar_problems_on_worksheet(self)
    math_problem.replacement_available?(:exclude => similars)
  end
  
  private
  
  def worksheet_exists
    begin
      errors.add(:worksheet_id, "doesn't exist") unless (!worksheet.nil? || (worksheet_id && Worksheet.exists?(worksheet_id)))
    rescue
      errors.add(:worksheet_id, "not found in db")
    end
  end
  
  def math_problem_exists
    begin
      errors.add(:math_problem_id, "doesn't exist") unless (!math_problem.nil? || (math_problem_id && MathProblem.exists?(math_problem_id)))
    rescue
      errors.add(:math_problem_id, "not found in db")
    end    
  end
  
  def renumber_remaining_worksheet_problems!
    worksheet.renumber_worksheet_problems!
    worksheet.reload
  end
end
