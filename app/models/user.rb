class User < ApplicationRecord
	has_secure_password
	has_many :user_hashtags
	has_many :hashtags , :through => :user_hashtags
	validates :username, presence: true
	validates :password_digest, presence: true,
						 length: { minimum: 5 }
end
