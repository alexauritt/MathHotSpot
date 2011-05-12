class Subject < ActiveRecord::Base
  has_many :categories
  has_many :lessons, :through => :categories
end
