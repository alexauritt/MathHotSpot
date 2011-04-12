require 'test_helper'

class SubjectsControllerTest < ActionController::TestCase
  setup do
    @request.env["HTTP_AUTHORIZATION"] = "Basic " + Base64::encode64("foo:bar")    
    @subject = subjects(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:subjects)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create subject" do
    assert_difference('Subject.count') do
      post :create, :subject => @subject.attributes
    end

    assert_redirected_to subject_path(assigns(:subject))
  end

  test "should show subject" do
    get :show, :id => @subject.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @subject.to_param
    assert_response :success
  end

  test "should update subject" do
    put :update, :id => @subject.to_param, :subject => @subject.attributes
    assert_redirected_to subject_path(assigns(:subject))
  end

  test "should destroy subject" do
    assert_difference('Subject.count', -1) do
      delete :destroy, :id => @subject.to_param
    end

    assert_redirected_to subjects_path
  end
end
