class Tweet
  include Mongoid::Document
  field :tweets, type: String
  field :location, type: Array
end
