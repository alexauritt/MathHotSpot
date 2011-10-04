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
  
  test "equation_editor_link" do
    text = 'Launch Equation Editor for Bruhahah'
    id = 'racous-bauchsou-asd'
    expected_html = "<a href=\"javascript:OpenLatexEditor('#{id}','latex','')\">#{text}</a>"
    assert_equal expected_html, equation_editor_link(text, id)
  end
end