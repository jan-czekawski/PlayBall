require 'test_helper'

class SignupNewUserTest < ActionDispatch::IntegrationTest

  def setup
    #ActionMailer::Base.deliveries.clear
  end

  test 'creating new user should not be successful with incorrect info' do
    get signup_path
    assert_template "users/new"
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "Bob", email: "bobat.co", password: "pas", password_confirmation: "word" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test 'creating new user, followed by correct activation should be successful' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do 
      post users_path, params: { user: { username: "Jerry", email: "jerry@example.com", password: "password", password_confirmation: "password" } }
    end
    user = assigns(:user)
    #assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to courts_path
    follow_redirect!
    assert_template 'courts/index'
    assert_select 'div#flash_info', 'Activation link was sent to your email address'
    assert_not logged_in_test?
    assert_not user.activated?
    log_in_test(user)
    assert_redirected_to courts_path
    follow_redirect!
    assert_select "div#flash_info", "Your account wasn't activated. Please check your email and activate your account."
    assert_not logged_in_test?

    get edit_account_activation_path("random text", email: user.email)
    assert_redirected_to courts_path
    follow_redirect!
    assert_select "div#flash_danger", "Your activation was not successfull. Link was not valid."
    log_in_test(user)
    assert_not logged_in_test?

    get edit_account_activation_path(user.activation_token, email: "randomemail@example.com")
    assert_redirected_to courts_path
    follow_redirect!
    assert_select "div#flash_danger", "Your activation was not successfull. Link was not valid."
    log_in_test(user)
    assert_not logged_in_test?

    get edit_account_activation_path(user.activation_token, email: user.email)
    assert_redirected_to courts_path
    follow_redirect!
    assert_select "div#flash_success", "Your account's just been activated! You can log in now."
    log_in_test(user)
    assert_redirected_to user
    follow_redirect!
    assert_select "div#flash_success", "You have successfully logged in"
    assert logged_in_test?
  end

end
