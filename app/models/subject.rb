class Subject < ActiveRecord::Base
  has_many :categories
  has_many :lessons
  
  validates_presence_of :title
end
