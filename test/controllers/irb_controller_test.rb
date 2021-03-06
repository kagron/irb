require 'test_helper'

class IrbControllerTest < ActionDispatch::IntegrationTest
  test "should get FormApps" do
    get irb_FormApps_url
    assert_response :success
  end

  test "should get ArchivedApps" do
    get irb_ArchivedApps_url
    assert_response :success
  end

  test "should get InProgressApps" do
    get irb_InProgressApps_url
    assert_response :success
  end

  test "should get StateApps" do
    get irb_StateApps_url
    assert_response :success
  end

end
