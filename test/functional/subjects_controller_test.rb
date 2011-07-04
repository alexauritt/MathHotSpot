require 'test_helper'

class SubjectsControllerTest < AuthenticatingControllerTestCase
  setup do    
    @subject = subjects(:algebraI)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subjects)
  end

  test "should show subject" do
    get :show, :id => @subject.to_param
    assert_response :success
  end

end
