require 'test_helper'

class IrbControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get irb_home_url
    assert_response :success
  end

  test "should get about" do
    get irb_about_url
    assert_response :success
  end

end
