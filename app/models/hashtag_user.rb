class HashtagUser < ApplicationRecord
	belongs_to :hashtag
	belongs_to :user
end
