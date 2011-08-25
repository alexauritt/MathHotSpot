require 'test_helper'
require 'mocha'

class WorksheetBuilderTest < ActiveSupport::TestCase

  def setup
    @user = users(:testuser)
  end
  test "create empty worksheet" do
    assert_difference('Worksheet.count') do
      @worksheet = WorksheetBuilder.build(:owner => @user, :title => "new worksheet")
      @worksheet.save
    end
    assert_equal "new worksheet", @worksheet.title
    assert_equal @user, @worksheet.owner
  end
  
  
  test "returns invalid Worksheet if no owner specified" do
    worksheet = WorksheetBuilder.build(:title => "invalid worksheet")
    assert !worksheet.valid?, "Worksheet should be invalid"
  end
  
  test "build returns empty Worksheet without attributes if attributes invalid" do
    worksheet = WorksheetBuilder.build(:whoohasdofijawe => "asdlfjasdf", :title => 'title should not be set')
    assert_equal false, worksheet.valid?, "Worksheet should not be valid, but should be present"
    assert_nil worksheet.title
  end
end