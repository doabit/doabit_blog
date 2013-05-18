require "spec_helper"

describe "Post" do
  before(:each) do
    @post = create(:post, tag_list: 'tag1,tag2')
    @no_published = create(:post, published: false)
  end

  context "posts list" do
    it "list posts only published" do
      visit '/posts'
      page.should have_content @post.title
      page.should have_link 'tag1'
      page.should have_link 'tag2'

      page.should_not have_content @no_published.title
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

  context "post archives" do
    it "list posts group by year-month" do
      visit '/archives'
      page.should have_content I18n.l(@post.created_at, format: :year_month)
      page.should have_content @post.title
      page.should_not have_content @no_published.title
    end
  end

end