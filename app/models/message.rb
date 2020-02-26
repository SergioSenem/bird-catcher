class Message < ApplicationRecord
	has_many :hashtag_messages
	has_many :hashtags, :through => :hashtag_messages
	validates :author, presence: true
	validates :body, presence: true
	validates :publication_date, presence: true

	require 'twitter'

	def self.get_messages_from_twitter
		tweets = get_tweets
		save_tweets(tweets)
	end

	def self.get_hashtag_messages_from_twitter(hashtag)
		client = get_twitter_client
		tweets = get_tweets_by_hashtag(hashtag.value)
		save_hashtag_tweets(hashtag.id, tweets)
	end

	private
	def self.get_twitter_client
		Twitter::REST::Client.new do |config|
	    	config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
	    	config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
	    	config.access_token        = ENV['ACCESS_TOKEN']
	    	config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
		end
	end

	def self.get_tweets
  		client = get_twitter_client

		hashtags = Hashtag.all
		tweets = Hash.new

		hashtags.each do |hashtag|
			tweets[hashtag.id] = get_tweets_by_hashtag(client, hashtag.value)
		end

		tweets
  	end

  	def self.get_tweets_by_hashtag(client, hashtag)
  		tweets = client.search("##{hashtag}").take(100)
  		remove_existing(tweets)
  	end

  	def self.remove_existing(tweets)
  		messages = Message.where(twitter_id: tweets.map(&:id))

  		new_tweets = Array.new
  		existing_tweets_ids = messages.map(&:twitter_id)

  		tweets.each do |tweet|
  			unless existing_tweets_ids.include?(tweet.id)
  				new_tweets.push(tweet)
  			end
  		end

  		return new_tweets
  	end

  	def self.save_tweets(messages)
  		messages.each do |hashtag, tweets|
  			save_hashtag_tweets(hashtag, tweets)
		end
  	end

  	def self.save_hashtag_tweets(hashtag_id, tweets)
  		tweets.each do |tweet|	
			message = save_message_from_tweet(tweet)
			save_hashtag_message(hashtag_id, message.id)
		end
  	end

  	def self.save_message_from_tweet(tweet)
  		message = Message.new
		message.twitter_id = tweet.id
		message.author = tweet.user.screen_name
		message.body = tweet.text
		message.publication_date = tweet.created_at

		message.save

		message
  	end

  	def self.save_hashtag_message(hashtag_id, message_id)
  		hashtag_message = HashtagMessage.new
		hashtag_message.hashtag_id = hashtag_id
		hashtag_message.message_id = message_id

		hashtag_message.save
  	end
end
