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
		f.resume	
	end

	#fetch trending tweets by location and trends
	def self.trends_by_location(hashtag, latitude, longitude)
		@tweets =[]
	  	TweetStream::Client.new.filter({:locations => '-80.29,32.57,-79.56,33.09', :track => ["google"]}) do |tweet|
	  		if tweet['geo']
	  		@tweets << Tweet.new(location: tweet['geo']['coordinates'],
								 status: tweet['text'],
				                 profile_pic_url:  tweet['user']['profile_image_url'],
					             user_handle: tweet['user']['screen_name'])

	  		return @tweets if @tweets.size == 3
	  		end
		end
	end

end


