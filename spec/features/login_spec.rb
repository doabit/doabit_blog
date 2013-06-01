# encoding: UTF-8
require 'spec_helper'
describe "the signup process" do

  it "Weibo Login", js: true do
    visit '/'
    page.should have_link "微博登录"
    click_link("微博登录")
    Account.last.uid.should == '1337'

    current_path.should == '/'
    page.should have_content("weibo_uname")
    page.should have_button("退出")
    page.should_not have_link("微博登录")

    click_button("退出")
    page.should have_link "微博登录"
    page.should_not have_link "退出"
    page.should_not have_content "weibo_uname"
  end

  it "Github Login", js: true do
    visit '/'
    page.should have_link "Github登录"
    click_link("Github登录")
    Account.last.uid.should == '1338'

    current_path.should == '/'
    page.should have_content("github_uname")
    page.should have_button("退出")
    page.should_not have_link("Github登录")

    click_button("退出")
    page.should have_link "Github登录"
    page.should_not have_link "退出"
    page.should_not have_link "github_uname"
  end

end