require 'spec_helper'

describe Tweet do

	describe "Find tweets by location" do

		before(:each) do
			# Mongoid.purge! 
			TweetLocator.fetch_and_save_tweets #adding tweets to the test database
		end

		it "gets the tweets given the coordinates" do
			@tweet = Tweet.new(:latitude => "-180" , :longitude => "90")
			@tweets =  @tweet.get_closest_tweets
			@tweets.should_not be_empty
			@tweets.first.should be_kind_of Tweet
		end

		it "returns error with no coordinates" do
			@tweet = Tweet.new(:latitude => "" , :longitude => "")
			@tweet.valid_coordinates?.should be_false
			@tweet.errors.full_messages.should be_kind_of(Array)
			@tweet.errors.full_messages.first.should == "The coordinates are invalid"
		end


		it "returns true with valid coordinates" do
			@tweet = Tweet.new(:latitude => "-20" , :longitude => "40.5")
			@tweet.valid_coordinates?.should be_true
			@tweet.errors.full_messages.should be_empty
		end

		it "retuns false with invalid coordinates" do
			@tweet = Tweet.new(:latitude => "-20,33.6" , :longitude => "40.5,45.5")
			@tweet.valid_coordinates?.should be_false
			@tweet.errors.full_messages.first.should == "The coordinates are invalid"
		end
	end
end
