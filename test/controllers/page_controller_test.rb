require 'test_helper'

class PageControllerTest < ActionDispatch::IntegrationTest

  test "should get landing page" do
    get root_url
    assert_response :success
    assert_select "button", "Begin!"
  end

  test "should get courts page" do
    get courts_url
    assert_response :success
    assert_select "a", "PlayBall"
  end

  test "should get signup page" do
    get signup_url
    assert_response :success
    assert_select "h1", "Sign up"
  end

  test "should get login page" do
    get login_url
    assert_response :success
    assert_select "h1", "Log in"
  end

  test "should get password reset page" do
    get new_password_reset_url
    assert_response :success
    assert_select "h1", "Password reset"
  end

end
