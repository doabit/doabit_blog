require "spec_helper"

describe "Post" do
  before(:each) do
    @post = create(:post, tag_list: 'tag1,tag2')
  end

  context "posts list" do
    it "list posts" do
      visit '/posts'
      page.should have_content @post.title
      page.should have_content 'tag1'
      page.should have_content 'tag2'
    end
  end

  context "post show" do
    it "show post" do
      visit '/posts'
      click_link @post.title
      # save_and_open_page
      page.should have_content @post.title
      page.should have_content @post.content
      current_path.should == "/posts/#{@post.to_param}"
    end
  end

end