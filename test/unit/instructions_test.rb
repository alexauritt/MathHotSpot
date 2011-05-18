require 'test_helper'

class InstructionsTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "won't save without description" do
    instruction = Instruction.new
    assert_equal false, instruction.save
  end
  
  test "to_s returns description" do
    message = "Do this thing!"
    instruction = Instruction.new(:description => message)
    assert_equal message, instruction.to_s
  end
end
