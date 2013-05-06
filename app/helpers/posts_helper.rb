# Helper methods defined here can be accessed in any controller or view in the application
module PostHelpers
  def get_day(date)
    "#{date.day < 10 ? '0' << date.day.to_s : date.day}"
  end
  def get_year_manth(date)
    "#{date.month < 10 ? '0' << date.month.to_s : date.month} / #{date.year}"
  end
end

DoabitBlog::App.helpers PostHelpers