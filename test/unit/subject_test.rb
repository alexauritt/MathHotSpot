require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  # Replace this with your real tests.

  def setup
    @subject = Subject.new
  end
  
  test "empty? returns true if subject has none of the following: lessons, problem_types, categories" do
    assert Subject.new.empty?, "Expected new subject to be empty"
  end
  
  test "empty? returns false if subject has lesson" do
    @subject = Subject.new
    @subject.lessons.build
    assert_equal false, @subject.empty?
  end
  
  test "empty? returns false if subject has a category" do
    @subject = Subject.new
    @subject.categories.build
    assert_equal false, @subject.empty?
  end
  
  test "empty? returns false if subject has both category and lesson" do
    @subject = Subject.new
    @subject.lessons.build    
    @subject.categories.build
    assert_equal false, @subject.empty?
  end
  
  test "name returns title" do
    @subject.title = "OOGA"
    assert_equal "OOGA", @subject.name
  end
  
  test "subject with lessons can not be destroyed" do
    subject = subjects(:algebraI)
    subject.lessons << Lesson.first
    assert !subject.destroy
  end
    
end
