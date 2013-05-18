# encoding: UTF-8
require "spec_helper"

describe "Tags" do
  let!(:post) { create(:post, tag_list: 'tag1, tag2') }
  let!(:no_published_post) { create(:post, tag_list: 'tag1, tag3', published: false) }

  it "list all tags" do
    visit '/tags'
    page.should have_link 'tag1'
    page.should have_link 'tag2'
    page.should have_link 'tag3'
  end

  it "show all posts with tag" do
    visit '/tags'
    click_link 'tag1'
    page.current_path.should == '/tags/tag1'

    page.should have_link post.title
    page.should_not have_link no_published_post.title
  end

end

