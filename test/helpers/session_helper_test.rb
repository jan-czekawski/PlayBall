require 'test_helper'
include SessionsHelper

class SessionHelperTest < ActionView::TestCase

  def setup
    @user = users(:one)
    remember(@user)
  end

  test "if session is nil current users should came from cookies" do
    assert_equal @user, current_user
    assert logged_in_test?
  end

  test "if remember digest is wrong current_user should be nil" do
    @user.update_attribute(:remember_digest, User.digest("wrong information"))
    assert_nil current_user
  end

end