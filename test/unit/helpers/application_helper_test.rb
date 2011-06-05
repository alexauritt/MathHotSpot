require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  
  def setup
    @cdn_script_link = "<script src=\"http://cdn.mathjax.org/mathjax/1.1-latest/MathJax.js?config=TeX-AMS-MML_HTMLorMML\" type=\"text/javascript\"></script>"
    @local_script_link = "<script src=\"/javascripts/math_jax/MathJax.js?config=TeX-AMS-MML_HTMLorMML,local/local.js\" type=\"text/javascript\"></script>"
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

end