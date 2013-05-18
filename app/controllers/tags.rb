DoabitBlog::App.controllers :tags do

  get :index, map: '/tags' do
    @tags = Tag.order("created_at desc")
    render 'tags/index'
  end

  get :show, map: "/tags/:name" do
    @tag = Tag.find_by_name(params[:name])
    @posts = @tag.posts.published.order("published_at desc")
    render 'posts/index'
  end

end
