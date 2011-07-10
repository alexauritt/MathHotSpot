require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
    
  def setup
    @cdn_script_link = "<script src=\"http://cdn.mathjax.org/mathjax/1.1-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML\" type=\"text/javascript\"></script>"
    @local_script_link = "<script src=\"/javascripts/math_jax/MathJax.js?config=TeX-AMS-MML_HTMLorMML,local/local.js\" type=\"text/javascript\"></script>"
  end

  test "user_login_or_logout_link returns Sign In if no one is logged in" do
    stubs(:user_signed_in?).returns(false)
    assert_equal link_to("Sign In", new_user_session_url), user_login_or_logout_link
  end
  
  test "user_login_or_logout_link returns Sign Out link if user currently logged in" do
    stubs(:user_signed_in?).returns(true)
    assert_equal link_to('Sign Out', destroy_user_session_url, :method => :delete), user_login_or_logout_link
  end
  
  test "display_level_number" do
    level = ProblemLevel.new(:level_number => 10)
    assert_equal "Level: 10", display_level_number(level)
  end
  
  test "display_level_number blank if no level_number set on level" do
    level = ProblemLevel.new
    assert_equal MathHotSpotErrors::Message::NO_LEVEL_NUMBER, display_level_number(level)
  end
  
  test "add CDN math link" do
    assert_equal @cdn_script_link, cdn_mathjax_link
  end
  
  test "add local mathjax link" do
    assert_equal @local_script_link, local_mathjax_link
  end
  
  test "include mathjax uses cdn in production mode" do
    ::Rails.env = "production"
    assert_equal @cdn_script_link, include_mathjax
  end
  
  test "include_math_jax" do
    assert_equal @local_script_link, include_mathjax
  end

  test "problem_count_msg multiple" do
    @problem_type.stubs(:problem_count).returns(7)
    assert_equal "7 Problems", problem_count_msg(@problem_type)
  end
  
  test "problem_count_msg singular" do
    @problem_type.stubs(:problem_count).returns(1)
    assert_equal "1 Problem", problem_count_msg(@problem_type)
  end
  
  test "problem_count_msg zip" do
    @problem_type.stubs(:problem_count).returns(0)
    assert_equal "0 Problems", problem_count_msg(@problem_type)
  end
  
  test "all_topics" do
    subject_list = 3.times.collect { Subject.new }
    category_list = 4.times.collect { Category.new }
    combo = subject_list + category_list
    Subject.expects(:all).returns(subject_list)
    Category.expects(:all).returns(category_list)
    
    assert_equal combo, all_topics
  end

end