class Tweet
 	include Mongoid::Document
  	field :status, type: String
  	field :location, type: Array
  	field :profile_pic_url , type: String
  	field :user_handle , type: String
  	
	index({ location: "2d" }, { min: -200, max: 200 })

	attr_accessor :latitude, :longitude
    
end
