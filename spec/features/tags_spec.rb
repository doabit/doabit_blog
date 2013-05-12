# encoding: UTF-8
require "spec_helper"

describe "Tags" do
  let!(:post) { create(:post, tag_list: 'tag1, tag2') }

  it "list all tags" do
    visit '/tags'
    page.should have_link 'tag1'
    page.should have_link 'tag2'
  end

  it "show all posts with tag" do
    visit '/tags'
    click_link 'tag1'
    page.current_path.should == '/tags/tag1'

    page.should have_link post.title
  end

end

