class Message < ApplicationRecord
	has_many :hashtag_messages
	has_many :hashtags, :through => :hashtag_messages
	validates :author, presence: true
	validates :body, presence: true
	validates :publication_date, presence: true
end
