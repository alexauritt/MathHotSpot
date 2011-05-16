require 'test_helper'

class AuthenticatingTestCase < ActionController::TestCase
  setup do
    authenticate
  end  
end

class MenusControllerTest < AuthenticatingTestCase
  
  test "should get index" do
    get :index
    assert assigns(:subjects), "@subjects not assigned"
    assert assigns(:tags), "@tags not assigned"
    assert_response :success
  end
end
