require 'test_helper'

class MenusControllerTest < ActionController::TestCase
  
  test "should get index when signed in" do
    sign_in users(:testuser)
    
    get :index
    assert assigns(:subjects), "@subjects not assigned"
    assert assigns(:tags), "@tags not assigned"
    assert_response :success
  end
  
  test "should be redirected to sign in page if not signed in" do
    get :index
    
    assert_redirected_to new_user_session_path
  end
end
