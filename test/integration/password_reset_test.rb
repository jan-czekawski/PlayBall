require 'test_helper'

class PasswordResetTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    ActionMailer::Base.deliveries.clear
  end

  test "password reset should be successfull if information is correct" do
    assert @user.authenticate("password")
    get new_password_reset_path
    assert_response :success

    post password_resets_path, params: { password_reset: { email: "" } }
    assert_equal 0, ActionMailer::Base.deliveries.size
    assert_template "password_resets/new"
    assert_not flash.empty?
    assert_select "div#flash_danger", "Email address cannot be empty."

    post password_resets_path, params: { password_reset: { email: "someRandomEmail@example.com" } }
    assert_equal 0, ActionMailer::Base.deliveries.size
    assert_template "password_resets/new"
    assert_not flash.empty?
    assert_select "div#flash_danger", "That email address does not exist in our database."

    post password_resets_path, params: { password_reset: { email: @user.email } }
    user = assigns(:user)
    assert_equal 1, ActionMailer::Base.deliveries.size
    assert_redirected_to courts_path
    follow_redirect!
    assert_select "div#flash_info", "Message with reset password link was sent to your email address."

    get edit_password_reset_path(user.reset_token, email: "wrongEmail@example.com")
    assert_redirected_to courts_path
    follow_redirect!
    assert_select "div#flash_danger", "Invalid password reset link"

    get edit_password_reset_path("wrongToken", email: @user.email)
    assert_redirected_to courts_path
    follow_redirect!
    assert_select "div#flash_danger", "Invalid password reset link"

    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: @user.email)
    assert_redirected_to courts_path
    follow_redirect!
    assert_select "div#flash_danger", "Invalid password reset link"
    user.toggle!(:activated)

    user.update_attribute(:reset_at, 3.hours.ago)
    get edit_password_reset_path(user.reset_token, email: @user.email)
    assert_redirected_to new_password_reset_path
    follow_redirect!
    assert_select "div#flash_danger", "Your password link has been expired."
    user.update_attribute(:reset_at, Time.now)

    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_template 'password_resets/edit'
    assert_select "h1", "Create new password"
    assert_select "input[name=email][type=hidden][value=?]", user.email

    patch password_reset_path(user.reset_token), params: {user: { password: "newPass", password_confirmation: "word" }, email: user.email }
    assert_template "password_resets/edit"
    assert_select "div#flash_danger", "There was an error. Please try again."

    patch password_reset_path(user.reset_token), params: {user: { password: "", password_confirmation: "" }, email: user.email }
    assert_template "password_resets/edit"
    assert_select "div#flash_danger", "Password cannot be empty."

    patch password_reset_path(user.reset_token), params: {user: { password: "newPassword", password_confirmation: "newPassword" }, email: user.email }
    assert_redirected_to login_path
    follow_redirect!
    assert_select "div#flash_success", "Your password was changed."
    assert_nil user.reload.reset_digest
    assert_not @user.reload.authenticate("password")
    assert @user.reload.authenticate("newPassword")
  end



end
