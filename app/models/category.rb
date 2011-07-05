class Category < ActiveRecord::Base
  belongs_to :subject
  has_many :problem_types
  has_many :lessons
end
