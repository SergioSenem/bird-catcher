class Message < ApplicationRecord
	has_many :hashtag_messages
	has_many :hashtags, :through => :hashtag_messages
end
