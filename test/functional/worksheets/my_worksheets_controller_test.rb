require 'test_helper'

class Worksheets::MyWorksheetsControllerTest < AuthenticatingControllerTestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
