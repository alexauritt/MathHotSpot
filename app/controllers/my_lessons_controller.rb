class MyLessonsController < ApplicationController
  def index
    @lessons = Lesson.find_all_by_owner_id(current_user)
    @problem_types = ProblemType.find_all_by_owner_id(current_user)
  end
end