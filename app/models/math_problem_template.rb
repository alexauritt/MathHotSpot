class MathProblemTemplate < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :instructions
  has_many :math_problems
  
  def self.find_replacement(math_problem)
    available_problems = MathProblem.find_all_by_math_problem_template_id(math_problem.math_problem_template.id)

    if available_problems.empty?
      raise ActiveRecord::RecordNotFound
      return nil
    end
    
    if (available_problems.count == 1)
      raise ActiveRecord::RecordNotFound
      return availble_problems.first
    end
    
    without_original = available_problems.delete_if {|problem| problem == math_problem}
    without_original[rand(without_original.size)]
  end
end
