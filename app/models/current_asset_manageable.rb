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
      clear_current_assets_in_session!
    rescue RightRabbitErrors::InvalidSessionState
      Rails.logger.error "Both Current Lesson and Current Worksheet were set in Session. THIS IS A NO NO!"
      flash.now[:notice] = RightRabbitErrors::DEFAULT      
      clear_current_assets_in_session!
    end
  end
  
  def current_lesson?
    !session[:current_lesson_id].nil? && session[:current_worksheet_id].nil?
  end
  
  def current_worksheet?
    session[:current_lesson_id].nil? && !session[:current_worksheet_id].nil?
  end
  
  def set_current_lesson_in_session! lesson_id
    session[:current_lesson_id] = lesson_id
    session[:current_worksheet_id] = nil
  end
  
  def set_current_worksheet_in_session! worksheet_id
    session[:current_lesson_id] = nil
    session[:current_worksheet_id] = worksheet_id    
  end
  
  def clear_current_lesson_in_session!
    session[:current_lesson_id] = nil    
  end
  
  def clear_current_worksheet_in_session!
    session[:current_worksheet_id] = nil  
  end
  
  def clear_current_assets_in_session!
    session[:current_lesson_id] = nil
    session[:current_worksheet_id] = nil    
  end
end