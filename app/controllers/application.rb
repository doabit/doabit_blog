DoabitBlog::App.controllers  do

  get :index , :map => '/' do
    @posts = Post.published.order("created_at desc")
    render 'posts/index'
  end

  get :profile do
    content_type :text
    current_account.to_yaml
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

end
