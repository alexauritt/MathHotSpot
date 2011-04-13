class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate

  def admin  
  end
  
  protected

  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "foo" && password == "bar"
    end
  end
end
