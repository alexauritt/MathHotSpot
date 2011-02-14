class MathProblemTemplate < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :instructions
  has_many :math_problems
end
