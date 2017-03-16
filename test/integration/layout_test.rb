require 'test_helper'

class LayoutTest < ActionDispatch::IntegrationTest


  test 'landing page layout' do
    get root_path
    assert_template 'pages/index'
    assert_select 'h1', 'PlayBall'
    assert_select 'p', 'Find the closest, the best court to play b-ball!'
    assert_select 'hr'
    assert_select 'a', 'Begin!'
  end




  test 'main layout' do
    get courts_path
    assert_template 'courts/index'
    assert_select 'a[href=?]', courts_path, count: 2
    assert_select 'a[id=?]', 'loginButton'
    assert_select 'a[id=?]', 'signupButton'
    assert_select 'a[id=?]', 'signupButton', count: 2
  end

end
