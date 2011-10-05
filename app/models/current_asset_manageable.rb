module CurrentAssetManageable
  def current_asset_specified_in_session!
    begin
      @current_asset = session[:current_lesson_id] ? Lesson.find(session[:current_lesson_id]) : nil
    rescue ActiveRecord::RecordNotFound
      session[:current_lesson_id] = nil
    end
  end
end