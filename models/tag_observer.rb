class TagObserver < ActiveRecord::Observer
  observe :tag

  def sweep(tag)
    DoabitBlog::App.cache.delete('/tags')
  end

  alias_method :after_update, :sweep
  alias_method :after_create, :sweep
  alias_method :after_destroy, :sweep
end