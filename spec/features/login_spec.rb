# encoding: UTF-8
require 'spec_helper'
describe "the signup process" do

  it "登录" do
    visit '/'
    page.should have_link "微博登录"
    click_link("微博登录")
    Account.last.uid.should == '1337'

    current_path.should == '/'
    page.should have_content("Test Name")
    page.should have_button("退出")
    page.should_not have_link("微博登录")

    click_button("退出")
    page.should have_link "微博登录"
    page.should have_link "Github"
    page.should_not have_content "退出"
    page.should_not have_content "Test Name"

  end
end