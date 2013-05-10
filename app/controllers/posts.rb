DoabitBlog::App.controllers :posts do

  get :index, map: '/posts' do
    @posts = Post.order("created_at desc")
    render 'posts/index'
  end

  get :show, map: "/posts/:id" do
    @post = Post.find(params[:id])
    @comments = @post.comments
    render 'posts/show'
  end

end
