require 'test_helper'

class SignupNewUserTest < ActionDispatch::IntegrationTest

  test 'creating new user should not be successful with incorrect info' do
    get signup_path
    assert_template "users/new"
    assert_no_difference 'User.count' do
      post users_path, params: { user: { username: "Bob", email: "bobat.co", password: "pas", password_confirmation: "word" } }
    end
    assert_template 'users/new'
    assert_select 'div#error_explanation'
  end

  test 'creating new user should be successful' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do 
      post users_path, params: { user: { username: "Jerry", email: "jerry@example.com", password: "password", password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'courts/index'
    assert_select 'div#flash_info', 'Activation link was sent to your email address'
    assert_not logged_in_test?
  end

end
