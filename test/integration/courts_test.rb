require 'test_helper'

class CourtTest < ActionDispatch::IntegrationTest

def setup
  @user = users(:one)
end

  test "adding new court should not be successfull with wrong information" do
    get courts_path
    assert_response :success
    log_in_test(@user)
    assert_redirected_to @user
    follow_redirect!
    assert_select "div.alert-success"
    get new_court_path
    assert_template 'courts/new'
    assert_no_difference("Court.count") do
      post courts_path, params: { court: { name: "", description: "random text", picture: "court.jpg", latitude: 10, longitude: 20 } }
    end
    assert_template 'courts/new'
    assert_select "div#error_explanation"
  end

  test "adding new court should be successfull with correct information" do
    log_in_test(@user)
    get new_court_path
    assert_template "courts/new"
    assert_difference("Court.count", 1) do
      post courts_path, params: { court: { name: "Buczka", description: "random text", picture: "court.jpg", latitude: 10, longitude: 20 } }
    end
    assert_redirected_to courts_path
    follow_redirect!
    assert_not flash.empty?
    assert_select "div.alert-success"
  end



end
