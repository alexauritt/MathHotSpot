module CurrentAssetManageable
  def current_asset_specified_in_session!
    begin
      raise RightRabbitErrors::InvalidSessionState if session[:current_lesson_id] && session[:current_worksheet_id]
      @current_asset = session[:current_lesson_id] ? Lesson.find(session[:current_lesson_id]) : nil
    rescue ActiveRecord::RecordNotFound
      session[:current_lesson_id] = nil
    rescue RightRabbitErrors::InvalidSessionState
      Rails.logger.error "Both Current Lesson and Current Worksheet were set in Session. THIS IS A NO NO!"
      flash.now[:notice] = RightRabbitErrors::DEFAULT      
      session[:current_lesson_id] = nil
      session[:current_worksheet_id] = nil
    end
  end
end