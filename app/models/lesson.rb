class Lesson < ActiveRecord::Base
  belongs_to :owner, :class_name => "User"

  has_many :core_lesson_problem_types, :dependent => :destroy
  has_many :problem_types, :through => :core_lesson_problem_types

  belongs_to :category
  belongs_to :subject  

  accepts_nested_attributes_for :problem_types, :reject_if => lambda { |problem_type| problem_type[:title].blank?}, :allow_destroy => true
  
  validates_presence_of :owner_id, :title
  
  def new_problem_type=(problem_type_id)
    begin
      problem_types << (ProblemType.find problem_type_id)
    rescue ActiveRecord::RecordNotFound, ActiveRecord::RecordInvalid
    end
  end

  def problem_type_count
    problem_types.size
  end
  
  def topic_name
    subject.nil? ? '' : subject.title
  end
end
