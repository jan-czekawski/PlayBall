require 'test_helper'

class CourtsTest < ActiveSupport::TestCase

  def setup
    @user = users(:one)
    @court = @user.courts.build(name: "Warta", description: "It's pretty togh court.", picture: 'blank.jpeg', longitude: 10, latitude: 20)
  end

  # test "court should be valid" do
  #   assert @court.valid?
  # end

  test "name is necessary" do
    @court.name = ""
    assert_not @court.valid?
  end

  test "name should not be too long" do
    @court.name = "x" * 256
    assert_not @court.valid?
  end

  test "description is necessary" do
    @court.description = ""
    assert_not @court.valid?
  end

  # test "picture is necessary" do
  #   @court.picture = ""
  #   assert_not @court.valid?
  # end

  # test "picture cannot be too big" do
  #   @court.picture.size = 5.1.megabytes
  #   assert_not @court.valid?
  # end

  test "user_id is necessary" do
    @court.user_id = ""
    assert_not @court.valid?
  end

  test "longitude is necessary" do
    @court.longitude = ""
    assert_not @court.valid?
  end

   test "latitude is necessary" do
    @court.latitude = ""
    assert_not @court.valid?
  end

end
