module CurrentAssetManageable
  def current_lesson_specified_in_session!
    begin
      @current_lesson = session[:current_lesson_id] ? Lesson.find(session[:current_lesson_id]) : nil
    rescue ActiveRecord::RecordNotFound
      session[:current_lesson_id] = nil
    end
  end
end