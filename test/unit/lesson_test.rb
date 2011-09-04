require 'test_helper'

class LessonTest < ActiveSupport::TestCase

  def setup
    @lesson = Lesson.new
  end
      
  test "topic_name returns empty string if no subject is specified" do
    assert_equal "", Lesson.new.topic_name
  end
  
  test "topic_name delegates to subject if present" do
    the_title = "asdfasdf"
    lesson = Lesson.new
    lesson.subject = Subject.new
    lesson.subject.expects(:title).returns(the_title)
    assert_equal the_title, lesson.topic_name
  end
  
  test "problem_type_count" do
    lesson = Lesson.create(:owner => users(:testuser), :title => "sample lesson")
    pt = problem_types(:find_gcf_of_monomials_problem_type)
    clpt = CoreLessonProblemType.create(:lesson => lesson, :problem_type => pt)
    assert_equal 1, lesson.problem_type_count
  end
  
  test "new_problem_type" do
    problem_type = Factory.create(:problem_type)
    assert_difference('@lesson.problem_type_count') do
      @lesson.new_problem_type = problem_type.id
    end
  end
  
  test "lesson catches error when attempting to add problem type already in lesson" do
    lesson = Factory.create(:lesson, :owner => User.first)
    problem_type = Factory.create(:problem_type)
    lesson.problem_types << problem_type
    assert_nothing_raised do
      lesson.new_problem_type = problem_type.id
    end
  end
  
  test "all_problem_levels returns empty array if level empty" do
    assert_equal [], @lesson.all_problem_levels
  end
  
  test "all_problem_levels returns all levels in all problem types" do
    first_type_levels = Array.new(3) {|i| ProblemLevel.new(:level_number => i)}
    third_type_levels = Array.new(2) {|i| ProblemLevel.new(:level_number => i)}
    type1 = ProblemType.new(:problem_levels => first_type_levels)
    type2 = ProblemType.new
    type3 = ProblemType.new(:problem_levels => third_type_levels)
    
    @lesson.problem_types << [type1, type2, type3]
    
    assert_equal first_type_levels + third_type_levels, @lesson.all_problem_levels
  end
  
  test "empty? returns true if lesson has problem types" do
    assert @lesson.empty?
  end
  
  test "empty? returns false if lesson has at least one problem type" do
    @lesson.problem_types << Factory.build(:problem_type, :owner => User.first)
    Rails.logger.info "pt #{@lesson.problem_types}"
    assert_equal false, @lesson.empty?
  end

end
