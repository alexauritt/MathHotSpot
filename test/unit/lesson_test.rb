require 'test_helper'

class LessonTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "lesson fixtures work like they should" do
    assert_equal 2, lessons(:dividing_monomials_lesson).section 
  end
end
