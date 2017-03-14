require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  def setup
    @user = users(:one)
  end

  # test "account_activation" do
  #   mail = UserMailer.account_activation(@user)
  #   assert_equal "Activate your account", mail.subject
  #   assert_equal @user.email, mail.to
  #   assert_equal "do-not-reply@at.com", mail.from
  # end

  # test "password_reset" do
  #   mail = UserMailer.password_reset(@user)
  #   assert_equal "Password reset", mail.subject
  #   assert_equal @user.email, mail.to
  #   assert_equal "do-not-reply", mail.from
  # end

end
