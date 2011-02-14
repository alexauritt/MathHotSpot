class MathProblemTemplate < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :instructions
end
