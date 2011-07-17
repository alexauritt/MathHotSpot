require 'test_helper'

class LessonsControllerTest < AuthenticatingControllerTestCase
  setup do
    @current_user = users(:testuser)
    @lesson = lessons(:dividing_monomials_lesson)
  end

  test "should show lesson" do
    get :show, {:category_id => @lesson.category.id, :id => @lesson.to_param }
    assert_response :success
  end
  
  test "should display empty problem type message if lesson contains a problem type with no levels" do
    Lesson.any_instance.stubs(:problem_types).returns([ProblemType.new(:permalink => "empty-problem-type", :title => "Empty Problem Type", :instruction => Instruction.new(:description => "blah blah"))])
    get :show, {:category_id => @lesson.category.id, :id => @lesson.to_param }
    assert_response :success
    assert_select "p.inline_math", MathHotSpotErrors::Message::NO_PROBLEMS_DEFINED_FOR_PROBLEM_TYPE
  end
  
  test "show should set lesson as current_lesson in session" do
    lesson = Factory.build(:lesson, :id => 56757)
    Lesson.stubs(:find).with(anything).returns(lesson)
    
    assert_nil session[:current_lesson_id]
    
    get :show, :id => lesson
    
    assert_equal lesson.id, session[:current_lesson_id]
    assert_response :success
  end
  
  test "new" do
    get :new
    assert_response :success
  end

  test "should create lesson" do
    assert_difference('Lesson.count') do
      post :create, :lesson => simple_lesson.attributes
    end

    assert_redirected_to my_lessons_url
  end
  
  test "create should set current_user as owner of new lesson" do
    post :create, :lesson => simple_lesson.attributes
    assert_equal @current_user, assigns(:lesson).owner
  end
  
  test "should update lesson" do
    put :update, :id => @lesson.to_param, :lesson => @lesson.attributes
    lesson = assigns(:lesson)
    assert_redirected_to lesson_path(lesson)
  end
    
  test "edit" do
    get :edit, :id => @lesson.to_param
    assert_response :success
  end

  test "index" do
    get :index
    assert_response :success
  end
  
  test "destroy" do
    assert_difference('Lesson.count', -1) do
      delete :destroy, :id => @lesson.to_param
    end
    assert_redirected_to my_lessons_path
  end

  # these comes later, once we've implemented authorization
  # test "should fail to update lesson owned by different user" do
  #   not_your_lesson = lessons(:joe_lesson)
  #   put :update, :id => not_your_lesson, :lesson => not_your_lesson.attributes
  #   assert_redirected_to lesson_path(not_your_lesson)
  #   assert_select 'p.notice', MathHotSpotErrors::Message::NOT_YOUR_LESSON
  # end
  # test "should not have access to edit page for lessons that don't belong to you" do
  # end
  


  private
  def simple_lesson
    Lesson.new(:title => 'a very simple lesson')
  end

end
