class Worksheet < ActiveRecord::Base
  has_many :worksheet_problems
  has_many :math_problems, :through => :worksheet_problems
end
