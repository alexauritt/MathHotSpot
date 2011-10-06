class MyLessonsController < ApplicationController
  include CurrentAssetManageable
  def index
    clear_current_lesson_in_session!
    @lessons = Lesson.find_all_by_owner_id(current_user)
  end  
end
