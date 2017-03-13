require 'test_helper'

class SignupNewUserTest < ActionDispatch::IntegrationTest

  def setup
    @user = User.new(username: "Boss", email: "boss@office.com", password: "password",password_confirmation: "password")
  end

  # test 'go to signup and add new user' do
  #   get signup_path
  #   assert_template "users/new"
  #   @user.save
  #   assert_redirected_to courts_path
  #   follow_redirect!
  #   assert_not_equal "flash", ""
  # end

  test 'creating new user should not be successful' do
    get signup_path
    assert_template "users/new"
    assert_no_difference 'User.count' do
      @user.password = "passw"
      @user.save
    end
    assert_template 'users/new'
    # assert_select 'em#user_password-error'
  end

  test 'creating new user should be successful' do
    get signup_path
    assert_template 'users/new'
    assert_difference 'User.count', 1 do 
      @user.save
    end
    # follow_redirect!
    # assert_template 'courts/index'
    # assert_redirected_to courts_path
    # assert_select 'div#flash_info', 'Activation link was sent to your email address'
  end

end
