class MathProblem < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :instructions
end
