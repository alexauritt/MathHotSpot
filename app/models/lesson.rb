class Lesson < ActiveRecord::Base
  belongs_to :category
  belongs_to :owner, :class_name => "User"
  belongs_to :subject
  has_and_belongs_to_many :problem_types
  
  validates_presence_of :owner_id, :title

  def template_count
    problem_types.size
  end
  
  def subject_title
    subject.nil? ? '' : subject.title
  end
end
