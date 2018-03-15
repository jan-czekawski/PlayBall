require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:one)
    @user2 = users(:two)
    @admin = users(:three)
    @court = @user.courts.create(name: "Warta", description: "Random description", picture: "", latitude: 10, longitude: 20)
    @comment = @court.comments.build(content: "New comment")
  end

  test "should add comment if logged in" do
    log_in_test(@user)
    assert_difference("Comment.count", 1) do
      post comments_path, params: { comment: { content: "My first comment!!!" }, court_id: @court.id }
    end
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_success", "Comment was successfully created!"
  end

  test "should not add comment if not logged in" do
    assert_no_difference("Comment.count") do
      post comments_path, params: { comment: { content: "My failed comment!!!" }, court_id: @court.id }
    end
    assert_redirected_to login_path
    follow_redirect!
    assert_select "div#flash_danger", "You must be logged in to perform that action"
  end

  test "comment should not be empty" do
    log_in_test(@user)
    assert_no_difference("Comment.count") do
      post comments_path, params: { comment: { content: "" }, court_id: @court.id }
    end
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_danger", "Content can't be blank"
  end

  test "should edit and destroy comment if logged in and creator of the comment" do
    log_in_test(@user)
    assert_difference("Comment.count", 1) do
      post comments_path, params: { comment: { content: @comment.content }, court_id: @court.id }
    end
    comment = assigns(:comment)
    assert_redirected_to court_path(@court)
    follow_redirect!

    patch comment_path(comment), params: { comment: { content: "" }, court_id: @court.id }
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_danger", "Content can't be blank"
    assert_equal comment.reload.content, comment.content

    patch comment_path(comment), params: { comment: { content: "My edited content" }, court_id: @court.id }
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_info", "Comment was successfully updated"
    assert_equal comment.reload.content, "My edited content"

    assert_difference("Comment.count", -1) do
      delete comment_path(comment), params: { court_id: @court.id }
    end
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_danger", "Comment was successfully deleted"  
  end

  test "should not edit and delete comment if not admin" do
    log_in_test(@user)
    assert_difference("Comment.count", 1) do
      post comments_path, params: { comment: { content: @comment.content }, court_id: @court.id }
    end
    comment = assigns(:comment)

    delete logout_path
    assert_not logged_in_test?
    patch comment_path(comment), params: { comment: { content: "My new edited content" }, court_id: @court.id }
    assert_redirected_to login_path
    follow_redirect!
    assert_select "div#flash_danger", "You must be logged in to perform that action"
    assert_equal comment.reload.content, comment.content
    assert_not_equal comment.reload.content, "My new edited content"

    assert_no_difference("Comment.count") do
      delete comment_path(comment), params: { court_id: @court.id }
    end
    assert_redirected_to login_path
    follow_redirect!
    assert_select "div#flash_danger", "You must be logged in to perform that action"

    log_in_test(@user2)
    patch comment_path(comment), params: { comment: { content: "My new edited content" }, court_id: @court.id }
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_danger", "You can only perform that action for your own comments"
    assert_equal comment.reload.content, comment.content
    assert_not_equal comment.reload.content, "My new edited content"

    assert_no_difference("Comment.count") do
      delete comment_path(comment), params: { court_id: @court.id }
    end
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_danger", "You can only perform that action for your own comments"

    delete logout_path
    assert_not logged_in_test?
    log_in_test(@admin)
    patch comment_path(comment), params: { comment: { content: "My edited content" }, court_id: @court.id }
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_info", "Comment was successfully updated"
    assert_equal comment.reload.content, "My edited content"

    assert_difference("Comment.count", -1) do
      delete comment_path(comment), params: { court_id: @court.id }
    end
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_danger", "Comment was successfully deleted"     
  end



end
