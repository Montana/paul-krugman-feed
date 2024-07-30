require 'rss'
require 'time'

def create_rss_feed(articles, author, title, about)
  RSS::Maker.make("2.0") do |maker|
    maker.channel.author = author
    maker.channel.updated = Time.now.to_s
    maker.channel.about = about
    maker.channel.title = title
    articles.each do |article|
      maker.items.new_item do |item|
        item.link = article[:link]
        item.title = article[:title]
        item.updated = article[:pub_date].to_s
        item.description = article[:description]
      end
    end
  end
end

articles = [
  {
    title: "The Economic Consequences of Mr. Trump",
    link: "https://www.nytimes.com/2020/01/01/opinion/trump-economy.html",
    description: "Paul Krugman discusses the economic policies of Donald Trump.",
    pub_date: Time.parse("2020-01-01")
  },
  {
    title: "The Rise and Fall of Bitcoin",
    link: "https://www.nytimes.com/2021/02/15/opinion/bitcoin.html",
    description: "Paul Krugman analyzes the volatility of Bitcoin.",
    pub_date: Time.parse("2021-02-15")
  },
]

rss = create_rss_feed(
  articles,
  "Paul Krugman",
  "Paul Krugman's RSS Feed",
  "Paul Krugman's Articles"
)

begin
  File.write("paul_krugman_rss.xml", rss.to_s)
  puts "RSS feed created successfully: paul_krugman_rss.xml"
rescue StandardError => e
  puts "Failed to create RSS feed: #{e.message}"
end
