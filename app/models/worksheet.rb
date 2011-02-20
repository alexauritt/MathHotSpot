class Worksheet < ActiveRecord::Base
  has_and_belongs_to_many :math_problems
end
