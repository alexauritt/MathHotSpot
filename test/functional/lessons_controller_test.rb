require 'test_helper'

class LessonsControllerTest < AuthenticatingControllerTestCase
  setup do
    @current_user = users(:testuser)
    @old_lesson = lessons(:dividing_monomials_lesson)
    @lesson = Factory.build(:lesson)
  end

  test "should show lesson" do
    get :show, {:category_id => @old_lesson.category.id, :id => @old_lesson.to_param }
    assert_response :success
  end
  
  test "should display empty problem type message if lesson contains a problem type with no levels" do
    Lesson.any_instance.stubs(:problem_types).returns([ProblemType.new(:permalink => "empty-problem-type", :title => "Empty Problem Type", :instruction => Instruction.new(:description => "blah blah"))])
    get :show, {:category_id => @old_lesson.category.id, :id => @old_lesson.to_param }
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
  
  test "new clears current_lesson_id from session" do
    get :new, nil, authenticated_session_with({'current_lesson_id' => 234234})
    assert_nil session[:current_lesson_id]
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
  
  test "get rid of simple lesson and use factory girl" do
    pending "clean up these tests..."
  end
  
  test "create should redirect where we want it to" do
    post :create, :lesson => @lesson.attributes
    assert_redirected_to my_lessons_path, "expected successful lesson creation to redirect to My Lessons"
  end
  
  test "create should set new lesson as current lesson in session" do
    post :create, :lesson => @lesson.attributes
    assert_equal Lesson.find_by_title(@lesson.title).id, session[:current_lesson_id]
  end
  
  test "should update lesson" do
    put :update, :id => @old_lesson.to_param, :lesson => @old_lesson.attributes
    lesson = assigns(:lesson)
    assert_redirected_to lesson_path(lesson)
  end
    
  test "edit" do
    get :edit, :id => @old_lesson.to_param
    assert_response :success
  end

  test "index" do
    get :index
    assert_response :success
  end
  
  test "destroy" do
    assert_difference('Lesson.count', -1) do
      delete :destroy, :id => @old_lesson.to_param
    end
    assert_redirected_to my_lessons_path
  end

  private
  def simple_lesson
    Lesson.new(:title => 'a very simple lesson')
  end

end
