class MyLessonsController < ApplicationController
  def index
    clear_current_lesson_from_session!
    @lessons = Lesson.find_all_by_owner_id(current_user)
  end
  
  private
  def clear_current_lesson_from_session!
    session[:current_lesson_id] = nil
  end
end
