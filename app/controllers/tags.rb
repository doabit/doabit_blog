DoabitBlog::App.controllers :tags do

  get :index, map: '/tags' do
    @tags = Tag.order("created_at desc")
    @title = '文章标签'
    render 'tags/index'
  end

  get :show, map: "/tags/:name" do
    @tag = Tag.find_by_name(params[:name])
    @posts = @tag.posts.published.order("published_at desc")
    @title = "#{@tag.name}相关文章"
    render 'posts/index'
  end

end
