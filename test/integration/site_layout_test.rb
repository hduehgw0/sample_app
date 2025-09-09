require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael) # fixtureからユーザーを取得
  end

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    get contact_path
    assert_select "title", full_title("Contact")
    # get signup_path
    # assert_select "title", full_title("Sign up")
  end

  test "layout links for logged-out user" do
    # 1. ホームページにアクセス
    get root_path

    # 2. 正しいページが表示されたか確認
    assert_template 'static_pages/home'

    # 3. 表示されるべきリンクの存在とリンク先を確認
    # ホームページへのリンクはロゴとナビゲーションの2つある
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path

    # 4. 表示されるべきでないリンクが存在しないことを確認
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "layout links for logged-in user" do
    # 1. テストヘルパーを使い、@user としてログインする
    log_in_as(@user)

    # 2. ホームページにアクセスする
    get root_path

    # 3. 表示されるべきリンクの存在とリンク先を確認
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", logout_path

    # 4. 表示されるべきでないリンクが存在しないことを確認
    assert_select "a[href=?]", login_path, count: 0
  end
end
