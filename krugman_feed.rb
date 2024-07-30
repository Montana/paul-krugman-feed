# frozen_string_literal: true

require 'rss'
require 'time'
require 'logger'

class RSSFeedCreator
  def self.create(articles, channel_info)
    RSS::Maker.make('2.0') do |maker|
      set_channel_info(maker.channel, channel_info)
      add_items(maker.items, articles)
    end
  end

  class << self
    private

    def set_channel_info(channel, info)
      channel.author = info[:author]
      channel.updated = Time.now.to_s
      channel.about = info[:about]
      channel.title = info[:title]
      channel.link = info[:link]
      channel.description = info[:description] || info[:about]
      channel.language = info[:language] || 'en-us'
      channel.ttl = info[:ttl] || 60
    end

    def add_items(items, articles)
      articles.each do |article|
        items.new_item do |item|
          item.link = article[:link]
          item.title = article[:title]
          item.updated = article[:pub_date].iso8601
          item.description = article[:description]
          item.author = article[:author] if article[:author]
          item.category = article[:category] if article[:category]
        end
      end
    end
  end
end

class RSSFeedWriter
  def self.write(rss, filename, logger)
    File.write(filename, rss.to_s)
    logger.info("RSS feed created successfully: #{filename}")
  rescue StandardError => e
    logger.error("Failed to write RSS feed: #{e.message}")
    raise
  end
end

class RSSFeedManager
  def initialize(logger = Logger.new($stdout))
    @logger = logger
  end

  def generate_and_write_feed(articles, channel_info, output_file)
    validate_input(articles, channel_info)
    rss = RSSFeedCreator.create(articles, channel_info)
    RSSFeedWriter.write(rss, output_file, @logger)
  rescue StandardError => e
    @logger.error("An error occurred: #{e.message}")
    @logger.error(e.backtrace.join("\n"))
  end

  private

  def validate_input(articles, channel_info)
    raise ArgumentError, "Articles cannot be empty" if articles.empty?
    raise ArgumentError, "Channel info is missing required fields" unless valid_channel_info?(channel_info)
  end

  def valid_channel_info?(info)
    [:author, :title, :about, :link].all? { |key| info[key] && !info[key].to_s.strip.empty? }
  end
end

articles = [
  {
    title: 'The Economic Consequences of Mr. Trump',
    link: 'https://www.nytimes.com/2020/01/01/opinion/trump-economy.html',
    description: 'Paul Krugman discusses the economic policies of Donald Trump.',
    pub_date: Time.parse('2020-01-01'),
    category: 'Economics'
  },
  {
    title: 'The Rise and Fall of Bitcoin',
    link: 'https://www.nytimes.com/2021/02/15/opinion/bitcoin.html',
    description: 'Paul Krugman analyzes the volatility of Bitcoin.',
    pub_date: Time.parse('2021-02-15'),
    category: 'Cryptocurrency'
  }
]

channel_info = {
  author: 'Paul Krugman',
  title: "Paul Krugman's RSS Feed",
  about: "Paul Krugman's Articles",
  link: 'https://www.nytimes.com/column/paul-krugman',
  language: 'en-us',
  ttl: 120
}

RSSFeedManager.new.generate_and_write_feed(articles, channel_info, 'paul_krugman_rss.xml')
