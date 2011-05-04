class Lesson < ActiveRecord::Base
  belongs_to :subject
  has_many :problem_types
  
  validates_presence_of :subject

  def template_count
    problem_types.size
  end
end
