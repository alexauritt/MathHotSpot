class Category < ActiveRecord::Base
  belongs_to :subject
  has_many :problem_types
  has_many :lessons

  validates_presence_of :title
  
  before_destroy :empty?
  
  def empty?
    problem_types.empty?
  end
  
  def title_with_subject
    "#{subject.title} -- #{title}"
  end
end
