DoabitBlog::App.controllers  do

  get :index , :map => '/', :cache => true do
    @posts = Post.published.order("created_at desc")
    @description = APP_CONFIG['site_description']
    # cache_key '/posts'
    render 'posts/index'
  end

  get :cache_layout, provides: :js do
    render 'home/cache_layout'
  end

  get :rss, provides: :rss do
    @posts = Post.published.order("created_at desc")
    render 'home/rss'
  end

  delete :logout, :map => '/logout' do
    set_current_account(nil)
    redirect url(:index)
  end


   %w(get post).each do |method|
    send(method, "/auth/:provider/callback") do
      auth    = request.env["omniauth.auth"]
      account = Account.find_by_provider_and_uid(auth["provider"], auth["uid"]) ||
                Account.create_with_omniauth(auth)
      set_current_account(account)
      redirect '/'
    end
  end

  get '/auth/failure' do
    flash[:notice] = params[:message] # if using sinatra-flash or rack-flash
    redirect '/'
  end

  get '/ie' do
    render 'home/ie', layout: false
  end

end
