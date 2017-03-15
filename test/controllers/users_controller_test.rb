require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:one)
    @user2 = users(:two)
    @user3 = users(:three)
  end

  test "should get index if logged in" do
    log_in_test(@user)
    get users_path
    assert_response :success
  end

  test "should not get index if not logged in" do
    get users_path
    assert_response :redirect
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
  end


  test "should get new user path" do
    get signup_path
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count', 1) do
      post users_path, params: { user: { email: "manny@example.com", password: "password", password_confirmation: "password", username: "Manny" } }
    end
    assert_redirected_to courts_path
    assert_not flash.empty?
  end

  test "should show user if logged in" do
    log_in_test(@user)
    get user_path(@user)
    assert_response :success
  end

  test "should not show user if not logged in" do
    get user_path(@user)
    assert_response :redirect
    assert_redirected_to login_path
    assert_not flash.empty?
  end



  test "should get edit" do
    log_in_test(@user)
    get edit_user_path(@user)
    assert_response :success
  end


  test "should update the same user" do
    log_in_test(@user)
    patch user_path(@user), params: { user: { email: @user.email, password: "password", username: @user.username } }
    assert_redirected_to @user
    follow_redirect!
    assert_select "div.alert-info"
  end

  test "should not update if user is not the same as logged in" do
    log_in_test(@user)
    patch user_path(@user2), params: { user: { email: @user2.email, password: "password", username: @user2.username } }
    assert_redirected_to @user2
    follow_redirect!
    assert_select "div.alert-danger"
  end

  test "should destroy user if logged in as admin" do
    log_in_test(@user3)
    assert_difference('User.count', -1) do
      delete user_path(@user)
    end
    assert_redirected_to users_path
  end

  test "should not destroy user if not logged in" do
    assert_no_difference('User.count') do
      delete user_path(@user)
    end
    assert_redirected_to login_path
  end

  test "should not destroy user if logged in, but not admin" do
    log_in_test(@user2)  
    assert_no_difference('User.count') do
      delete user_path(@user)
    end
    assert_redirected_to users_path
  end

  test "should not be able to edit :admin attribute" do
    log_in_test(@user)
    assert_not @user.admin?
    patch user_path(@user), params: { user: { admin: true } }
    @user.reload
    assert_not_equal @user.admin, true
  end

end
