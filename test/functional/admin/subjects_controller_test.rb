require 'test_helper'

class Admin::SubjectsControllerTest < AuthenticatingControllerTestCase
  setup do
    @subject = subjects(:algebraI)
  end

  test "should get new as admin" do
    get :new
    assert_response :success
  end

  test "should create subject as admin" do
    assert_difference('Subject.count') do
      post :create, :subject => @subject.attributes
    end

    assert_redirected_to subject_path(assigns(:subject))
  end
  
  test "should get edit as admin" do
    get :edit, :id => @subject.to_param
    assert_response :success
  end

  test "should update subject as admin" do
    put :update, :id => @subject.to_param, :subject => @subject.attributes
    assert_redirected_to subject_path(assigns(:subject))
  end

  test "should destroy subject as admin" do
    new_subject = Subject.create(:title => "A Very Short Lived Subject")

    assert_difference('Subject.count', -1) do
      delete :destroy, :id => new_subject.to_param
    end

    assert_redirected_to admin_subjects_path
  end
  
end
