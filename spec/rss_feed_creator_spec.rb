# frozen_string_literal: true

require_relative '../krugman_feed'

RSpec.describe RSSFeedCreator do
  let(:articles) do
    [
      {
        title: 'Test Article',
        link: 'https://example.com/test',
        description: 'This is a test article.',
        pub_date: Time.parse('2023-01-01')
      }
    ]
  end

  describe '.create' do
    it 'creates an RSS feed' do
      rss = described_class.create(
        articles,
        'Test Author',
        'Test Feed',
        'Test Description',
        'https://example.com'
      )

      expect(rss).to be_a(RSS::Rss)
      expect(rss.channel.title).to eq('Test Feed')
      expect(rss.items.size).to eq(1)
      expect(rss.items.first.title).to eq('Test Article')
    end
  end
end
