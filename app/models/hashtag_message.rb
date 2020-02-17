class HashtagMessage < ApplicationRecord
	belongs_to :hashtag
	belongs_to :message
end
