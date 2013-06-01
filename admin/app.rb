require 'xmlrpc/client'
module DoabitBlog
  class Admin < Padrino::Application
    use ActiveRecord::ConnectionAdapters::ConnectionManagement
    register Padrino::Rendering
    register Padrino::Mailer
    register Padrino::Helpers
    register Padrino::Admin::AccessControl

    set :session_id, "my_shared_session_id"

    helpers do
      def ping_search_engine(post)
        # http://www.google.cn/intl/zh-CN/help/blogsearch/pinging_API.html
        # http://www.baidu.com/search/blogsearch_help.html
        baidu = XMLRPC::Client.new2("http://ping.baidu.com/ping/RPC2")
        baidu.timeout = 5  # set timeout 5 seconds
        baidu.call("weblogUpdates.extendedPing",
                   APP_CONFIG['site_title'],
                   APP_CONFIG['site_domain'],
                   APP_CONFIG['site_domain'] + DoabitBlog::App.url(:posts, :show, id: post),
                   APP_CONFIG['site_domain'] + '/rss')

        google = XMLRPC::Client.new2("http://blogsearch.google.com/ping/RPC2")
        google.timeout = 5  # set timeout 5 seconds
        google.call("weblogUpdates.extendedPing",
                    APP_CONFIG['site_title'],
                    APP_CONFIG['site_domain'],
                    APP_CONFIG['site_domain'] + DoabitBlog::App.url(:posts, :show, id: post),
                    APP_CONFIG['site_domain'] + '/rss')
      rescue Exception => e
        logger.error e
      end
    end

    ##
    # Application configuration options
    #
    # set :raise_errors, true         # Raise exceptions (will stop application) (default for test)
    # set :dump_errors, true          # Exception backtraces are written to STDERR (default for production/development)
    # set :show_exceptions, true      # Shows a stack trace in browser (default for development)
    # set :logging, true              # Logging in STDOUT for development and file for production (default only for development)
    # set :public_folder, "foo/bar"   # Location for static assets (default root/public)
    # set :reload, false              # Reload application files (default in development)
    # set :default_builder, "foo"     # Set a custom form builder (default 'StandardFormBuilder')
    # set :locale_path, "bar"         # Set path for I18n translations (default your_app/locales)
    # disable :sessions               # Disabled sessions by default (enable if needed)
    # disable :flash                  # Disables sinatra-flash (enabled by default if Sinatra::Flash is defined)
    # layout  :my_layout              # Layout can be in views/layouts/foo.ext or views/foo.ext (default :application)
    #

    set :admin_model, 'Account'
    set :login_page,  '/admin/sessions/new'

    enable  :sessions
    disable :store_location

    access_control.roles_for :any do |role|
      role.protect '/'
      role.allow   '/sessions'
    end

    access_control.roles_for :admin do |role|
    role.project_module :comments, '/comments'
    role.project_module :uploads, '/uploads'
      role.project_module :tags, '/tags'
      role.project_module :posts, '/posts'
      role.project_module :accounts, '/accounts'
    end

    before do
      halt 403 if current_account and current_account.role == 'commenter'
    end

    # Custom error management
    error(403) { @title = "Error 403"; render('errors/403', :layout => :error) }
    error(404) { @title = "Error 404"; render('errors/404', :layout => :error) }
    error(500) { @title = "Error 500"; render('errors/500', :layout => :error) }
  end
end
