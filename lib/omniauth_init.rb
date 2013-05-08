module OmniauthInitializer
  def self.registered(app)
    app.use OmniAuth::Builder do
      provider :developer,:fields => [:first_name, :last_name] unless Padrino.env == :production
      provider :weibo, APP_CONFIG['WEIBO_KEY'], APP_CONFIG['WEIBO_SECRET']
      provider :github, APP_CONFIG['GITHUB_KEY'], APP_CONFIG['GITHUB_SECRET']
    end
  end
end