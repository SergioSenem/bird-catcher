class Hashtag < ApplicationRecord
  has_many :user_hashtags
  has_many :users , :through => :user_hashtags
end
