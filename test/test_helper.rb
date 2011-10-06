ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def assert_current_asset_display_in_view(present = true)
    assert_select '.assert-header', present, "Presence of .assert-header expected to be #{present}"
    assert_select '#current-asset-short', present, "Presence of #current-lesson expected to be #{present}"
  end

  def assert_problem_type_search_displayed_in_view(present = true)
    assert_select '#problem-type-search', present
  end

end

class ActionController::TestCase
  include Devise::TestHelpers
end

class AuthenticatingControllerTestCase < ActionController::TestCase
  setup do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    @current_user = Factory.create(:user)
    sign_in @current_user
  end
  
  def assert_no_error_message
    assert_error_message nil
  end
  
  def assert_error_message(message)
    message.nil? ? assert_nil(flash[:notice]) : assert_equal(message, flash[:notice])
  end  
end
