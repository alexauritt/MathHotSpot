module CurrentAssetManageable
  def current_asset_specified_in_session!
    begin
      raise RightRabbitErrors::InvalidSessionState if session[:current_lesson_id] && session[:current_worksheet_id]
      if session[:current_lesson_id]
        @current_asset = Lesson.find(session[:current_lesson_id])
      elsif session[:current_worksheet_id]
        @current_asset = Worksheet.find(session[:current_worksheet_id])
      else
        @current_asset = nil
      end
      @current_asset
    rescue ActiveRecord::RecordNotFound
      Rails.logger.error "Invalid Asset specified in session (probably a Lesson or a Worksheet)"
      flash.now[:notice] = RightRabbitErrors::DEFAULT
      clear_current_assets_from_session!
    rescue RightRabbitErrors::InvalidSessionState
      Rails.logger.error "Both Current Lesson and Current Worksheet were set in Session. THIS IS A NO NO!"
      flash.now[:notice] = RightRabbitErrors::DEFAULT      
      clear_current_assets_from_session!
    end
  end
  
  def clear_current_assets_from_session!
    session[:current_lesson_id] = nil
    session[:current_worksheet_id] = nil    
  end
end