require 'test_helper'

class CourtsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @court = @user.courts.create( name: "Buczka", description: "Shabby court...", picture: "court.jpg", latitude: 10, longitude: 20)
    @user2 = users(:two)
    @admin = users(:three)
  end

  test "should get court index page" do
    get courts_path
    assert_response :success
  end

  test "shouldn't be able to add new courts, if not logged in" do
    get new_court_path
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
  end

  test "should be able to add new courts page if logged in" do
    log_in_test(@user)
    get new_court_path
    assert_response :success
    assert_difference('Court.count', 1) do
      post courts_path, params: { court: { name: @court.name, description: @court.description, picture: @court.picture, latitude: @court.latitude, longitude: @court.longitude }}
    end
    assert_redirected_to courts_path
    follow_redirect!
    assert_not flash.empty?
  end

  test "should edit court if logged in and created that particular court" do
    log_in_test(@user)
    get edit_court_path(@court)
    assert_response :success
    patch court_path(@court), params: { court: { name: "edited court" }}
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_not flash.empty?
    @court.reload
    assert_equal @court.name, "edited court"
  end

  test "shouldn't get edit court page if not logged in" do
    get edit_court_path(@court)
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test "shouldn't get edit court page if court created by someone else" do
    log_in_test(@user2)
    get edit_court_path(@court)
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_not flash.empty?
  end

  test "shouldn't edit court if not logged in" do
    patch court_path(@court), params: { court: { name: "edited court" } }
    assert_redirected_to login_path
    follow_redirect!
    assert_not flash.empty?
    assert_not_equal @court.name, "edited court"
  end

  test "shouldn't edit court if court created by someone else" do
    log_in_test(@user2)
    patch court_path(@court), params: { court: { name: "edited court" } }
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_not flash.empty?
    assert_not_equal @court.name, "edited court"
  end

  test "should edit court if user is admin" do
    log_in_test(@admin)
    get edit_court_path(@court)
    assert_response :success
    patch court_path(@court), params: { court: { name: "edited by admin" } }
    assert_redirected_to court_path(@court)
    assert_not flash.empty?
    @court.reload
    assert_equal @court.name, "edited by admin"
  end

  test "should delete court if logged in and created that court" do
    log_in_test(@user)
    assert_difference('Court.count', -1) do
      delete court_path(@court)
    end
    assert_redirected_to courts_path
    assert_not flash.empty?
  end

  test "shouldn't delete court if not logged in" do
    assert_no_difference('Court.count') do
      delete court_path(@court)
    end
    assert_redirected_to login_path
    assert_not flash.empty?
  end

  test "shouldn't delete court if hadn't created that court" do
    log_in_test(@user2)
    assert_no_difference('Court.count') do
      delete court_path(@court)
    end
    assert_redirected_to court_path(@court)
    assert_not flash.empty?
  end

  test "should delete court if user is admin" do
    log_in_test(@admin)
    assert_difference("Court.count", -1) do
      delete court_path(@court)
    end
    assert_redirected_to courts_path
    follow_redirect!
    assert_not flash.empty?
  end

  test "court is dependant on user's existance" do
    log_in_test(@admin)
    assert_difference("Court.count", -1) do
      delete user_path(@user)
    end
    assert_redirected_to users_path
    follow_redirect!
    assert_not flash.empty?
  end


end
