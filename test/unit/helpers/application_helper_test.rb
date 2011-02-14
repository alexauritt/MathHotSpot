require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "display_mathml" do
    markup = '<mfrac><mrow><msup><mi>a</mi><mn>3</mn></msup></mrow><mrow><msup><mi>a</mi><mn>8</mn></msup></mrow></mfrac>'    
    problem = MathProblem.new(:problem_markup => markup)
    assert_equal(markup, display_mathml(problem))
  end  
end