class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :owner, :class_name => "User"
  has_one :subject, :through => :category
  has_many :problem_types
  
  validates_presence_of :owner, :title

  def template_count
    problem_types.size
  end
end
