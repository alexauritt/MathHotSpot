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

  test "title_with_subject" do
    category = Category.new(:title => "Fun With Napkins!")
    category.build_subject(:title => "Science")
    assert_equal "Science -- Fun With Napkins!", category.title_with_subject
  end
  
  test "calling title_with_subject twice should return the same value each time" do
    # regression test -- there was a bug in Category#title_with_subject
    category = Category.new(:title => "Fun With Napkins!")
    category.build_subject(:title => "Science")
    assert_equal "Science -- Fun With Napkins!", category.title_with_subject
    assert_equal "Science -- Fun With Napkins!", category.title_with_subject
  end
  
end
