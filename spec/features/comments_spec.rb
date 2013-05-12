# encoding: UTF-8
require "spec_helper"


describe "Comments" do
  let!(:post) { create(:post) }

  it "登录添加评论", js: true do
    login_with("微博登录")
    add_comment(post)
    page.should have_content "this is comment"
    page.should have_content "评论成功"

    page.should have_link 'weibo_uname', href: 'http://www.weibo.com/weibo_uname'
    page.should have_css('img[alt="weibo_uname"]')
    find_field("comment_content").value.should == ''
  end

  it "未登录添加评论", js: true do
    add_comment(post)
    page.should_not have_content "this is comment"
    page.should have_link '微博登录'
    page.should have_link 'Github登录'
    page.should have_content "请登录后评论"
    # save_and_open_page
  end
end

