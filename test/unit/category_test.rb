require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def setup
    @category = Category.new
    @sample_title = "Fun With Napkins!"
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

  test "name" do
    category = Category.new(:title => @sample_title)
    category.build_subject(:title => "Science")
    assert_equal "Science -- Fun With Napkins!", category.name
  end
  
  test "calling name twice should return the same value each time" do
    # regression test -- there was a bug in Category#name
    category = Category.new(:title => @sample_title)
    category.build_subject(:title => "Science")
    assert_equal "Science -- Fun With Napkins!", category.name
    assert_equal "Science -- Fun With Napkins!", category.name
  end
  
  test "name just returns title when subject is nil" do
    category = Category.new(:title => @sample_title)
    assert_equal @sample_title, category.name
  end
  
end
