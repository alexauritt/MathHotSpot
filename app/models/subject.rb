class Subject < ActiveRecord::Base
  include Topicable
  
  has_many :categories
  has_many :problem_types, :through => :categories
  has_many :lessons
  
  validates_presence_of :title
    
  before_destroy :empty?
  
  def empty?
    lessons.empty? && categories.empty?
  end
    
end
