require 'test_helper'

class CommentsTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @court = @user.courts.create(name: "Warta", description: "It's pretty togh court.", picture: 'blank.jpeg', longitude: 10, latitude: 20)
    @comment = @court.comments.build(user_id: @user.id, content: "random words")
  end
  
  test "comment should be valid" do
    assert @comment.valid? 
  end
  
  test "content is necessary" do
    @comment.content = ""
    assert_not @comment.valid?
  end
  
  test "user_id is necessary" do
    @comment.user_id = nil
    assert_not @comment.valid?
  end
  
  test "courts_id is necessary" do
    @comment.court_id = nil
    assert_not @comment.valid?
  end
end