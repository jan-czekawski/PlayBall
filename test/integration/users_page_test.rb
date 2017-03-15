require 'test_helper'

class UsersPageTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @admin = users(:three)
  end

  test "non-admin user should not see delete/edit links on index user page" do
    log_in_test(@user)
    get users_path
    assert_select "a[href=?]", user_path(@user), text: "Show"
    assert_select "a[href=?]", edit_user_path(@user), text: "Edit", count: 0
    assert_select "a[href=?]", user_path(@user), text: "Delete", count: 0
  end

  test "admin should see delete/edit links on index user page" do
    log_in_test(@admin)
    get users_path
    assert_select "a[href=?]", user_path(@user), text: "Show"
    assert_select "a[href=?]", edit_user_path(@user), text: "Edit"
    assert_select "a[href=?]", user_path(@user), text: "Delete"
  end
end
