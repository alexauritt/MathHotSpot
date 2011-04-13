class Lesson < ActiveRecord::Base
  belongs_to :subject
  has_many :math_problem_templates
  
  validates_presence_of :subject

  def template_count
    math_problem_templates.size
  end
end
