require 'pp'
require 'rubygems'
require 'tweetstream' 
require 'eventmachine'
require 'fiber'

class TweetLocator
	#get tweets
	def self.fetch_and_save_tweets
		EventMachine.run do #using eventmachine on tweet insert

			client = TweetStream::Client.new	
			@tweet_fibers = [Fiber.current]
		
			client.locations(-180, -90, 180, 90) do |tweet|
				@tweet_fibers << Fiber.new do
					self.save_tweet_to_db(tweet)
				end
				@tweet_fibers.last.resume
			end
		end #end of eventmachine run
	end

	#save tweet
	def self.save_tweet_to_db(tweet)
		if tweet['geo']
			Tweet.create!({
				location: tweet['geo']['coordinates'],
				status: tweet['text'],
			    profile_pic_url:  tweet['user']['profile_image_url'],
				user_handle: tweet['user']['screen_name']
			})
		end
		
	end
end


