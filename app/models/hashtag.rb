class Hashtag < ApplicationRecord
  has_many :user_hashtags
  has_many :users, :through => :user_hashtags  
  has_many :hashtag_messages
  has_many :messages, :through => :hashtag_messages
end
