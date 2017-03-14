require 'test_helper'

class NewSessionTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
  end

  test "successfull login" do
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: @user.email, password: 'password' }}
    assert_redirected_to @user
    follow_redirect!
    assert_not flash.empty?
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", new_court_path
    assert_select "a[id=?]", "loginButton", count: 0
    assert_select "a[id=?]", "signupButton", count: 0
    assert logged_in_test?
  end

  test "unsuccessfull login" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'wrongpassword' }}
    assert_template "sessions/new"
    assert_not flash.empty?
    assert_select "a[id=?]", "loginButton"
    assert_select "a[id=?]", "signupButton"
    assert_select "a[href=?]", new_court_path, count: 0
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", users_path, count: 0
    assert_not logged_in_test?
  end

  test "logout after successfull login" do
    get login_path
    post login_path, params: { session: { email: @user.email, password: 'password' }}
    assert logged_in_test?
    assert_redirected_to @user
    follow_redirect!
    assert_not flash.empty?
    delete logout_path
    assert_redirected_to courts_path
    follow_redirect!
    assert_not logged_in_test?
    assert_not flash.empty?
    assert_select "a[id=?]", "loginButton"
    assert_select "a[id=?]", "signupButton"
    assert_select "a[href=?]", new_court_path, count: 0
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", users_path, count: 0
  end

  test "login without remembering" do
    cookies['remember_token'] = "random"
    log_in_test(@user, remember: 0)
    assert_empty cookies['remember_token']
  end

  test "login with remembering" do
    log_in_test(@user, remember: 1)
    assert_not_empty cookies['remember_token']
  end

  test "should not log out if user is not logged in" do
    delete logout_path
    assert_redirected_to courts_path
  end

end
