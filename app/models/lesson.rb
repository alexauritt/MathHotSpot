class Lesson < ActiveRecord::Base
  belongs_to :category
  has_one :subject, :through => :category
  has_many :problem_types
  
  validates_presence_of :category

  def template_count
    problem_types.size
  end
end
