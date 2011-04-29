require 'test_helper'

class InstructionsTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "won't save without description" do
    instruction = Instruction.new
    assert_equal false, instruction.save
  end
end
