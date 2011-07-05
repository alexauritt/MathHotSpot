require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @category = Category.new
  end
  
  test "empty? returns true when categories have problem_types" do
    assert @category.empty?
  end
  
  test "empty? returns false is a category has no ProblemTypes" do
    @category.problem_types.build
    assert_equal false, @category.empty?
  end
  
  test "categories can not be destroy unless they have no problem types" do
    category = categories(:empty_category)
    category.problem_types.build(:title => "A problem type", :owner => users(:testuser))
    assert_equal false, category.destroy
  end
  
  
end
