require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(username: "Bartek", email: "bartus@hogwarts.com", password: "password", password_confirmation: "password")
  end

  test 'user should be valid' do 
    assert @user.valid?
  end

  test 'username should be present' do
    @user.username = ""
    assert_not @user.valid?
  end

  test 'email should be unique' do
    @user2 = User.new(username: "Bartus", email: "bartus@hogwarts.com", password: "password", password_confirmation: 'password')
    @user.save
    assert_not @user2.valid?
  end

  test 'email should be present' do
    @user.email = ""
    assert_not @user.valid?
  end

  test 'username cannot be too long' do
    @user.username = 'x' * 51
    assert_not @user.valid?
  end

  test 'password should be present' do
    @user.password = ''
    @user.valid?
  end

  test 'email address cannot be too long' do
    @user.email = 'x' * 256 + '@wp.pl'
    assert_not @user.valid?
  end

  test 'email address should have correct format' do
    @user.email = 'abcatcom.pl'
    assert_not @user.valid?
  end

  test 'password and password confirmation should be the same' do
    @user.password = 'password'
    @user.password_confirmation = 'rubbish'
    assert_not @user.valid?
  end

  test 'password should not be too short' do
    @user.password = 'passw'
    @user.password_confirmation = 'passw'
    assert_not @user.valid?
  end

  test 'email address should be downcased before save' do
    random_email = "BOOOM@wp.PL"
    @user.email = random_email
    @user.save
    assert_equal random_email.downcase, @user.reload.email
  end

end
