class Instruction < ActiveRecord::Base
  has_many :problem_types
  validates_presence_of :description
  
  def to_s
    self.description
  end
end
