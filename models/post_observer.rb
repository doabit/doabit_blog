class PostObserver < ActiveRecord::Observer
  observe :post

  def sweep(post)
    DoabitBlog::App.cache.delete(['/', '/posts', '/archives', '/about'])
  end

  alias_method :after_update, :sweep
  alias_method :after_create, :sweep
  alias_method :after_destroy, :sweep
end