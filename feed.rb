require 'nokogiri'
require 'mechanize'
require 'json' # can still use xml Montana prefers JSON 

# You can test this via: 
#!/usr/bin/env ruby
#require './feed'

puts Feed.new.rss

class Feed

  BLOG_URL = 'http://krugman.blogs.nytimes.com/'

  def html
    agent = Mechanize.new do |agent|
      agent.user_agent_alias = 'Mac Safari'
    end
    page = agent.get(BLOG_URL).content

    @html ||= Nokogiri::HTML(page) do |config|
      config.options = Nokogiri::XML::ParseOptions::NONET | Nokogiri::XML::ParseOptions::NOERROR
    end
  end

  def rss
    items = html.css('article').map do |article|
      date = 
      url = article.at('h3 a')['href'].split('?')[0]
      item = <<-ITEM
        <item>
          <title>#{article.css('h3').text}</title>
          <description>
            <![CDATA[ #{article.css('.entry-content').inner_html} ]]>
          </description>
          <pubDate>#{article.at('time')['datetime']}</pubDate>
          <link>#{url}</link>
          <guid>#{url}</guid>
        </item>
        ITEM
    end

    @rss ||= <<-RSS.strip
      <?xml version="1.0"?>
      <rss version="2.0" >
        <channel>
          <title>#{html.css('title').text}</title>
          <link>#{BLOG_URL}</link>
          #{items.join('')}
        </channel>
      </rss>
    RSS
  end
end
