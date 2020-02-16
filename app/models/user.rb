class User < ApplicationRecord
	has_secure_password
	has_many :hashtags, dependent: :destroy
	validates :username, presence: true
	validates :password_digest, presence: true,
						 length: { minimum: 5 }
end
