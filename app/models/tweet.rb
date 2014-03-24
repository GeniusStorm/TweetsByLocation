class Tweet
 	include Mongoid::Document
  	field :status, type: String
  	field :location, type: Array
  	field :profile_pic_url , type: String
  	field :user_handle , type: String
  	
	index({ location: "2d" }, { min: -200, max: 200 })

	attr_accessor :latitude, :longitude
    

	def get_closest_tweets
       Tweet.where(:location.near => [longitude, latitude]).limit(50).to_a
	end

	def valid_coordinates? 
		if [longitude, latitude].map(&:present?).include?(false)
			errors.add(:base , "Latitude/Longitude must be present") 
	    	return false
		else
			return true
		end	
	end
end
