xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  xml.title   APP_CONFIG['site_title']
  xml.link    "rel" => "self", "href" => uri(url_for(:posts, :index))
  xml.id      uri url_for(:posts, :index)
  xml.updated @posts.first.updated_at.strftime "%Y-%m-%d %H:%M:%S" if @posts.any?
  xml.author  { xml.name "doabit" }

  @posts.each do |post|
    xml.entry do
      xml.title   post.title
      xml.link    "rel" => "alternate", "href" => url(url_for(:posts, :show, :id => post))
      xml.id      url(url_for(:posts, :show, :id => post))
      xml.updated post.updated_at.strftime "%Y-%m-%d %H:%M:%S"
      xml.summary do
        xml.cdata!(markdown(post.content).html_safe)
      end
    end
  end
end