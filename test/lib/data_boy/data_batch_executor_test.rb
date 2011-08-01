require "test/unit"
require_relative '../../../lib/data_boy/data_boy'
require_relative '../../../lib/data_boy/data_batch_executor'

class DataBatchExecutorTest < Test::Unit::TestCase
  def test_message_initially_nil
    assert_nil DataBatchExecutor.message
  end  
end
