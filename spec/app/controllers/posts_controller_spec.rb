require 'spec_helper'

describe "PostsController" do

  describe "GET index" do
    it "renders the index" do
      get '/'
      last_response.should be_ok
    end
  end

  describe "Get show" do
    before(:each) do
      @post = create(:post)
    end

    it "renders the show" do
      get "/posts/#{@post.to_param}"
      last_response.should be_ok
    end
  end

end
