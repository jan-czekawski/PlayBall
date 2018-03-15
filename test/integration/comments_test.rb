require 'test_helper'

class CommentsIntegrationTest < ActionDispatch::IntegrationTest

  def setup
    @bob = users(:one)
    @john = users(:two)
    @admin = users(:three)
    @court = @bob.courts.create(name: "Warta", description: "Random description", picture: "", latitude: 10, longitude: 20)
    @comment = @court.comments.build(content: "New comment")
  end

  test "add, edit and delete comments" do
    get court_path(@court)
    assert_not logged_in_test?
    assert_select "a.btn-info", text: "Add Comment", count: 0
    assert_select "a.btn-xs", text: "Edit", count: 0
    assert_select "a.btn-xs", text: "Delete", count: 0
    
    log_in_test(@bob)
    assert logged_in_test?
    get court_path(@court)
    assert_select "a.btn-info", text: "Add Comment"
    assert_difference("Comment.count", 1) do
      post comments_path, params: { comment: { content: "My first comment!!!" }, court_id: @court.id }
    end
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_success", "Comment was successfully created!"
    assert_select "a.btn-xs", text: "Edit"
    assert_select "a.btn-xs", text: "Delete"
    
    delete logout_path
    get court_path(@court)
    assert_select "a.btn-info", text: "Add Comment", count: 0
    assert_select "a.btn-xs", text: "Edit", count: 0
    assert_select "a.btn-xs", text: "Delete", count: 0

    log_in_test(@john)
    get court_path(@court)
    assert_select "a.btn-info", text: "Add Comment"
    assert_select "a.btn-xs", text: "Edit", count: 0
    assert_select "a.btn-xs", text: "Delete", count: 0
    assert_difference("Comment.count", 1) do
      post comments_path, params: { comment: { content: "And this is MY first comment!!!" }, court_id: @court.id }
    end
    assert_redirected_to court_path(@court)
    follow_redirect!
    assert_select "div#flash_success", "Comment was successfully created!"
    assert_select "a.btn-info", text: "Add Comment"
    assert_select "a.btn-xs", text: "Edit"
    assert_select "a.btn-xs", text: "Delete"

    delete logout_path
    log_in_test(@admin)
    get court_path(@court)
    assert_select "a.btn-info", text: "Add Comment"
    assert_select "a.btn-xs", text: "Edit"
    assert_select "a.btn-xs", text: "Delete"

  end

end
