require 'spec_helper'

module Feedjira::Parser
  describe '#will_parse?' do
    it 'should return true for a feedburner atom feed' do
      expect(AtomFeedBurner).to be_able_to_parse(sample_feedburner_atom_feed)
    end

    it 'should return false for an rdf feed' do
      expect(AtomFeedBurner).to_not be_able_to_parse(sample_rdf_feed)
    end

    it 'should return false for a regular atom feed' do
      expect(AtomFeedBurner).to_not be_able_to_parse(sample_atom_feed)
    end

    it 'should return false for an rss feedburner feed' do
      expect(AtomFeedBurner).to_not be_able_to_parse sample_rss_feed_burner_feed
    end
  end

  describe 'parsing old style feeds' do
    before(:each) do
      @feed = AtomFeedBurner.parse(sample_feedburner_atom_feed)
    end

    it 'should parse the title' do
      expect(@feed.title).to eq 'Paul Dix Explains Nothing'
    end

    it 'should parse the description' do
      description = 'Entrepreneurship, programming, software development, politics, NYC, and random thoughts.' # rubocop:disable Metrics/LineLength
      expect(@feed.description).to eq description
    end

    it 'should parse the url' do
      expect(@feed.url).to eq 'http://www.pauldix.net/'
    end

    it 'should parse the feed_url' do
      expect(@feed.feed_url).to eq 'http://feeds.feedburner.com/PaulDixExplainsNothing'
    end

    it 'should parse no hub urls' do
      expect(@feed.hubs.count).to eq 0
    end

    it 'should parse hub urls' do
      AtomFeedBurner.preprocess_xml = false
      feed_with_hub = AtomFeedBurner.parse(load_sample('TypePadNews.xml'))
      expect(feed_with_hub.hubs.count).to eq 1
    end

    it 'should parse entries' do
      expect(@feed.entries.size).to eq 5
    end

    it 'should change url' do
      new_url = 'http://some.url.com'
      expect{ @feed.url = new_url }.not_to raise_error
      expect(@feed.url).to eq new_url
    end

    it 'should change feed_url' do
      new_url = 'http://some.url.com'
      expect{ @feed.feed_url = new_url }.not_to raise_error
      expect(@feed.feed_url).to eq new_url
    end
  end

  describe 'parsing alternate style feeds' do
    before(:each) do
      @feed = AtomFeedBurner.parse(sample_feedburner_atom_feed_alternate)
    end

    it 'should parse the title' do
      expect(@feed.title).to eq 'Giant Robots Smashing Into Other Giant Robots'
    end

    it 'should parse the description' do
      description = 'Written by thoughtbot'
      expect(@feed.description).to eq description
    end

    it 'should parse the url' do
      expect(@feed.url).to eq 'https://robots.thoughtbot.com'
    end

    it 'should parse the feed_url' do
      expect(@feed.feed_url).to eq 'http://feeds.feedburner.com/GiantRobotsSmashingIntoOtherGiantRobots'
    end

    it 'should parse hub urls' do
      expect(@feed.hubs.count).to eq 1
    end

    it 'should parse entries' do
      expect(@feed.entries.size).to eq 3
    end

    it 'should change url' do
      new_url = 'http://some.url.com'
      expect{ @feed.url = new_url }.not_to raise_error
      expect(@feed.url).to eq new_url
    end

    it 'should change feed_url' do
      new_url = 'http://some.url.com'
      expect{ @feed.feed_url = new_url }.not_to raise_error
      expect(@feed.feed_url).to eq new_url
    end
  end

  describe 'preprocessing' do
    it 'retains markup in xhtml content' do
      AtomFeedBurner.preprocess_xml = true

      feed = AtomFeedBurner.parse sample_feed_burner_atom_xhtml_feed
      entry = feed.entries.first

      expect(entry.content).to match(/\A\<p/)
    end
  end
end
