require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  # test "should get index" do
  #   NO SESSIONS
  #   get users_url
  #   if logged_in?
  #     assert_response :success
  #   else
  #     assert_response :redirect
  #   end
  # end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  # test "should create user" do
  #   assert_difference('User.count') do
  #     post users_url, params: { user: { email: @user.email, password_digest: @user.password_digest, username: @user.username } }
  #   end

  #   assert_redirected_to user_url(User.last)
  # end

  # test "should show user" do
  #   NO SESSIONS
  #   get user_url(@user)
  #   assert_response :success
  # end

  # test "should get edit" do
  #   NO SESSIONS
  #   get edit_user_url(@user)
  #   assert_response :success
  # end

  # test "should update user" do
  #   patch user_url(@user), params: { user: { admin: @user.admin, email: @user.email, password_digest: @user.password_digest, username: @user.username } }
  #   assert_redirected_to user_url(@user)
  # end

  # test "should destroy user" do
  #   assert_difference('User.count', -1) do
  #     delete user_url(@user)
  #   end

  #   assert_redirected_to users_url
  # end
end
