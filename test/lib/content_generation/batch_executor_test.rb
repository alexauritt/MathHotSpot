require "test/unit"
require_relative '../../../lib/content_generation/batch_executor'

class BatchExecutorTest < Test::Unit::TestCase
  def setup
    @dbe = BatchExecutor.new
  end
  
  def test_message_initially_nil
    assert_nil @dbe.message
  end
end
