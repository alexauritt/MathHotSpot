class WorksheetProblem < ActiveRecord::Base
  belongs_to :worksheet
  belongs_to :math_problem
  
  validates_presence_of :math_problem_id
  validates_uniqueness_of :problem_number, :scope => :worksheet_id
  validate :worksheet_exists
  after_destroy :renumber_remaining_worksheet_problems!
  
  def problem_level
    math_problem.nil? ? nil : math_problem.problem_level
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
    self.math_problem = current_problem.find_replacement(options)
    save
  end
  
  private
  
  def worksheet_exists
    begin
      errors.add(:worksheet_id, "doesn't exist") unless (!worksheet.nil? || (worksheet_id && Worsheet.exists?(worksheet_id)))
    rescue
      errors.add(:worksheet_id, "not found in db")
    end
  end
  
  def renumber_remaining_worksheet_problems!
    worksheet.renumber_worksheet_problems!
    worksheet.reload
  end
end
