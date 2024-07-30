# frozen_string_literal: true

require 'rss'
require 'time'

# RSSFeedCreator generates RSS feeds from article data
class RSSFeedCreator
  def self.create(articles, author, title, about, link)
    RSS::Maker.make('2.0') do |maker|
      set_channel_info(maker.channel, author, title, about, link)
      add_items(maker.items, articles)
    end
  end

  class << self
    private

    def set_channel_info(channel, author, title, about, link)
      channel.author = author
      channel.updated = Time.now.to_s
      channel.about = about
      channel.title = title
      channel.link = link
      channel.description = about
    end

    def add_items(items, articles)
      articles.each do |article|
        items.new_item do |item|
          item.link = article[:link]
          item.title = article[:title]
          item.updated = article[:pub_date].iso8601
          item.description = article[:description]
        end
      end
    end
  end
end

articles = [
  {
    title: 'The Economic Consequences of Mr. Trump',
    link: 'https://www.nytimes.com/2020/01/01/opinion/trump-economy.html',
    description: 'Paul Krugman discusses the economic policies of Donald Trump.',
    pub_date: Time.parse('2020-01-01')
  },
  {
    title: 'The Rise and Fall of Bitcoin',
    link: 'https://www.nytimes.com/2021/02/15/opinion/bitcoin.html',
    description: 'Paul Krugman analyzes the volatility of Bitcoin.',
    pub_date: Time.parse('2021-02-15')
  }
]

begin
  rss = RSSFeedCreator.create(
    articles,
    'Paul Krugman',
    'Paul Krugman\'s RSS Feed',
    'Paul Krugman\'s Articles',
    'https://www.nytimes.com/column/paul-krugman'
  )

  output_file = 'paul_krugman_rss.xml'
  File.write(output_file, rss.to_s)
  puts "RSS feed created successfully: #{output_file}"
rescue StandardError => e
  puts "Failed to create RSS feed: #{e.message}"
end
