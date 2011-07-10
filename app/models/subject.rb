class Subject < ActiveRecord::Base
  has_many :categories
  has_many :lessons
  
  validates_presence_of :title
    
  before_destroy :empty?
  
  def empty?
    lessons.empty? && categories.empty?
  end
  
  def name
    title
  end
  
end
