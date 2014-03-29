require 'rubygems'
require 'tweetstream' 
require 'eventmachine'
require 'fiber'

class TweetLocator
	#get tweets
	def self.fetch_and_save_tweets
		EventMachine.run do #using eventmachine on tweet insert
			Fiber.new {
			client = TweetStream::Client.new
			client.locations(-180, -90, 180, 90) do |tweet|
				self.save_tweet_to_db(tweet)		
			end
			}.resume
		end #end of eventmachine run	
	end

	#save tweet
	def self.save_tweet_to_db(tweet)
		f = Fiber.current
		if tweet['geo']
			Tweet.create!({
				location: tweet['geo']['coordinates'],
				status: tweet['text'],
			    profile_pic_url:  tweet['user']['profile_image_url'],
				user_handle: tweet['user']['screen_name']
			})
		end
		return Fiber.yield	
	end

	#fetch trending tweets by location and trends
	def self.trends_by_location(hashtag, latitude, longitude)
		  @tweets =[]
		 loc = [longitude,latitude].join(',')
		 client = TweetStream::Client.new
	  	 client.locations(loc, :track => hashtag) do |tweet|
	  		@tweets << Tweet.new(location: tweet['geo'] && tweet['geo']['coordinates'],
								 status: tweet['text'],
				                 profile_pic_url:   tweet['user'] && tweet['user']['profile_image_url'],
					             user_handle: tweet['user'] && tweet['user']['screen_name'])
	  		return @tweets if @tweets.size  == 10
		end
	end

end


