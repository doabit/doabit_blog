DoabitBlog::App.controllers :posts do

  get :index, map: '/(posts)' do
    @posts = Post.all
    render 'posts/index'
  end

  get :show, map: "/posts/:id-:slug" do
    @post = Post.find(params[:id])
    render 'posts/show'
  end

end
