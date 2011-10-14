require 'test_helper'
require 'integration_test_helper'

class SimpleLoginTest < ActionDispatch::IntegrationTest

  include ActionController::IntegrationTest::ProblemTypeSearchy

  # Replace this with your real tests.
  test "prompts for login" do
    visit(root_path)
    assert_equal new_user_session_path, current_path
  end
  
  test "logins in successfully" do
    user = Factory.create(:user)
    
    visit(root_path)
    fill_in 'user_email', :with => user.email
    fill_in 'user_password', :with => user.password
    click_button('Sign in')
  
    assert_equal root_path, current_path    
  end
end
