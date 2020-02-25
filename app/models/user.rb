class User < ApplicationRecord
	has_secure_password
	has_many :hashtag_users
	has_many :hashtags , :through => :hashtag_users
	validates :username, presence: true
	validates :password_digest, presence: true,
						 length: { minimum: 5 }
end
