# encoding: UTF-8
DoabitBlog::App.controllers :posts do

  get :index, map: '/(posts)', :provides => [:html, :rss, :atom], :cache => true do
    @posts = Post.published.order("created_at desc")
    @description = APP_CONFIG['site_description']
    render 'posts/index'
  end

  get :show, map: "/posts/:id" do
    @post = Post.find(params[:id])
    @title = @post.title
    @comments = @post.comments
    render 'posts/show'
  end

  get :archives, map: '/archives', :cache => true do
    @posts = Post.published.order('published_at desc').group_by { |t| t.published_at.beginning_of_month }
    @title = '文章档案'
    render 'posts/archives'
  end

  get :about, map: '/about', :cache => true do
    @post = Post.where(slug: 'about').first
    @title = '关于doabit'
    render 'posts/about'
  end

end
