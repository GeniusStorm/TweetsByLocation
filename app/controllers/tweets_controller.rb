class TweetsController < ApplicationController

  def index 
    @tweets = Tweet.new
  end

  def find
    @tweets = Tweet.new(params)

    @closest_tweets = @tweets.get_closest_tweets if @tweets.valid_coordinates?

    respond_to do |format|
      format.html { render :action => 'index' , :locals => {:tweets => @tweets  , :closest_tweets => @closest_tweets } }
      format.json { render json: @closest_tweets }
    end
  end

end