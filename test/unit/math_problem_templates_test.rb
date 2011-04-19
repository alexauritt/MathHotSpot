require 'test_helper'
require 'mocha'

class MathProblemTemplateTest < ActiveSupport::TestCase
  include MathHotSpotErrors
  # Replace this with your real tests.
  
  def setup
  end
      
  test "use display mode by default" do
    assert MathProblemTemplate.new.display_mode
  end
  
  test "set display mode to false" do
    mpt = MathProblemTemplate.new
    mpt.display_mode = false
    assert_equal false, mpt.display_mode
  end
  

end
