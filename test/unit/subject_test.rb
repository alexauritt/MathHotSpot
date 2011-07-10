require 'test_helper'

class SubjectTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "empty? returns true if subject has none of the following: lessons, problem_types, categories" do
    assert Subject.new.empty?, "Expected new subject to be empty"
  end
  
  test "empty? returns false if subject has lesson" do
    subject = Subject.new
    subject.lessons.build
    assert_equal false, subject.empty?
  end
  
  test "empty? returns false is subject has a category" do
    subject = Subject.new
    subject.categories.build
    assert_equal false, subject.empty?
  end
end
