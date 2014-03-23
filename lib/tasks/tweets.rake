require 'tweet_locator'

namespace :tweets do
  desc "Seeds the tweets from Twitter's public stream to the DB"
  task :seedstream => :environment do
  	TweetLocator.fetch_and_save_tweets
  end
end
