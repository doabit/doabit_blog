require "spec_helper"

describe "Post" do
  before(:each) do
    @post = create(:post)
  end

  context "posts list" do
    it "list posts" do
      visit '/posts'
      page.should have_content @post.title
    end
  end

  context "post show" do
    it "show post" do
      visit '/posts'
      click_link @post.title
      # save_and_open_page
      page.should have_content @post.title
      page.should have_content @post.content
      current_path.should == "/posts/#{@post.id}-#{@post.slug}"
    end
  end
end