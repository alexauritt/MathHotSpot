require 'test_helper'

class InstructionsControllerTest < AuthenticatingControllerTestCase

  def setup
    @lesson = lessons(:dividing_monomials_lesson)
  end

  test "new" do
    get :new, :lesson_id => @lesson.id
    assert_response :success
  end

  test "create" do
    instruction = Instruction.new
    instruction.description = "Do that thing you're supposed to do."
    assert_difference('Instruction.count') do
      post :create, :instruction => instruction.attributes, :lesson_id => @lesson.id
    end

    assert_redirected_to new_lesson_problem_type_path(@lesson)
  end
end
