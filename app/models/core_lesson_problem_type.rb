class CoreLessonProblemType < ActiveRecord::Base
  belongs_to :lesson
  belongs_to :problem_type
  validates_presence_of :problem_type_id, :lesson_id
  validates_uniqueness_of :problem_type_id, :scope => :lesson_id
end
