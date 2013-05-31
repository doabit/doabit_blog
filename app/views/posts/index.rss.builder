xml.instruct!
xml.rss "version" => "2.0", "xmlns:dc" => "http://purl.org/dc/elements/1.1/" do
  xml.channel do
    xml.title APP_CONFIG['site_title']
    xml.description APP_CONFIG['site_description']
    xml.link uri(url_for(:posts, :index))

    for post in @posts
      xml.item do
        xml.title post.title
        xml.description do
          xml.cdata!(markdown(post.content).html_safe)
        end
        xml.pubDate post.updated_at.strftime "%Y-%m-%d %H:%M:%S"
        xml.link uri(url_for(:posts, :show, :id => post))
      end
    end
  end
end