require "test/unit"
require_relative '../../../lib/data_boy/data_boy'
require_relative '../../../lib/data_boy/data_batch_executor'

class DataBatchExecutorTest < Test::Unit::TestCase
  def setup
    @dbe = DataBatchExecutor.new
  end
  
  def test_message_initially_nil
    assert_nil @dbe.message
  end
end
