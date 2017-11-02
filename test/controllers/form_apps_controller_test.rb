require 'test_helper'

class FormAppsControllerTest < ActionDispatch::IntegrationTest
  test "should get ArchivedApps" do
    get form_apps_ArchivedApps_url
    assert_response :success
  end

  test "should get InProgressApps" do
    get form_apps_InProgressApps_url
    assert_response :success
  end

  test "should get StateApps" do
    get form_apps_StateApps_url
    assert_response :success
  end

end
