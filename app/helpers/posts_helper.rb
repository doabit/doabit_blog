# Helper methods defined here can be accessed in any controller or view in the application
require 'rouge/plugins/redcarpet'
class HTML < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet
end

module PostHelpers
  include TruncateHtmlHelper
  def get_day(date)
    "#{date.day < 10 ? '0' << date.day.to_s : date.day}"
  end
  def get_year_manth(date)
    "#{date.month < 10 ? '0' << date.month.to_s : date.month} / #{date.year}"
  end

   def markdown(text)
    markdown = Redcarpet::Markdown.new(HTML, :autolink => true, fenced_code_blocks: true,
      :space_after_headers => true)
    markdown.render(text)
  end

end

DoabitBlog::App.helpers PostHelpers