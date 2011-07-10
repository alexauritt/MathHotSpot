require 'test_helper'
require 'integration_test_helper'

class SimpleLoginTest < ActionDispatch::IntegrationTest

  def setup
    User.create(:email => "jim@jimbo.com", :password => "secret")
  end
  
  # Replace this with your real tests.
  test "prompts for login" do
    visit(root_path)
    assert_equal new_user_session_path, current_path
  end
  
  test "logins in successfully" do
    visit(root_path)
    fill_in 'user_email', :with => 'jim@jimbo.com'
    fill_in 'user_password', :with => 'secret'
    click_button('Sign in')
  
    assert_equal root_path, current_path

    find_link('My Dashboard')
    find_link('Create a New Problem Type')
    page.has_content?('Search by Tags')
    
  end
end
