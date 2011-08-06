require "test/unit"
require_relative '../../../lib/content_generation/batch_executor'

class BatchExecutorTest < Test::Unit::TestCase
  def setup
    @be = BatchExecutor.new
  end
  
  def test_message_initially_nil
    assert_nil @be.message
  end
end
