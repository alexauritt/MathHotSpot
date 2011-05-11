class Category < ActiveRecord::Base
  belongs_to :subject
  has_many :lessons
end
