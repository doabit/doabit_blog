# encoding: UTF-8
require "spec_helper"

describe "Admin" do
  describe "login with admin" do
    it "should login with admin" do
      account = Account.create :name => 'admin', role: 'admin', email: 'demo@test.com',
                password: 'password', password_confirmation: 'password'
      visit '/admin/sessions/new'
      fill_in 'email', with: account.email
      fill_in 'password', with: 'password'
      click_button '登录系统'
      current_path.should == '/admin/'
    end
  end

  describe "login with weibo", js: true do
    it "should show halt 403" do
      login_with("微博登录")
      visit '/admin'
      page.should have_content '403'
    end
  end

  describe "login with github", js: true do
    it "should show halt 403" do
      login_with("Github登录")
      visit '/admin'
      page.should have_content '403'
    end
  end

  describe "not login" do
    it "should show login page" do
      visit '/admin'
      current_path.should == '/admin/sessions/new'
    end
  end
end