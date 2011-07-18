class Lesson < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"
  has_and_belongs_to_many :problem_types

  belongs_to :category
  belongs_to :subject  

  accepts_nested_attributes_for :problem_types, :reject_if => lambda { |problem_type| problem_type[:title].blank?}, :allow_destroy => true
  
  validates_presence_of :owner_id, :title

  def add_problem_type(problem_type)
    problem_types << problem_type
  end

  def template_count
    problem_types.size
  end
  
  def topic_name
    subject.nil? ? '' : subject.title
  end
end
