ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/reporters"
Minitest::Reporters.use!

# include ApplicationHelper
# include SessionsHelper

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

    # Log in as a particular user.
  def log_in_test(user)
    session[:user_id] = user.id
  end

  def logged_in_test?
    !session[:user_id].nil?
  end

  def current_user_test
    @current_user ||= User.find_by("id", session[:user_id])
  end
end





class ActionDispatch::IntegrationTest


  # Log in as a particular user.
  def log_in_test(user, password: 'password', remember_me: '1')
    post login_path, params: { session: { email: user.email,
                                          password: password,
                                          remember_me: remember_me } }
  end
end