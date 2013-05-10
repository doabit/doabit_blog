DoabitBlog::App.controllers :comments, :parent => :posts do

  post :create, provides: :js  do
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build account: current_account, content: params[:comment][:content]
    render "comments/create"
  end

end
