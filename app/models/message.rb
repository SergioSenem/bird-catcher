class Message < ApplicationRecord
	has_many :hashtag_messages
	has_many :hashtags, :through => :hashtag_messages
	validates :body, presence: true
	validates :author, presence: true
	validates :publication_date, presence: true
end
