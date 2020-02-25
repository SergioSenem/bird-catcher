class User < ApplicationRecord
	has_secure_password
	has_many :hashtags_users
	has_many :hashtags , :through => :hashtags_users
	validates :username, presence: true
	validates :password_digest, presence: true,
						 length: { minimum: 5 }
end
