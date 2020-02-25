class Hashtag < ApplicationRecord
  has_many :hashtags_users
  has_many :users, :through => :hashtags_users  
  has_many :hashtag_messages
  has_many :messages, :through => :hashtag_messages
  validates :value, presence: true
end
