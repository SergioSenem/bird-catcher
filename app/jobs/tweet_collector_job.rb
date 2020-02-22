class TweetCollectorJob < ApplicationJob
  queue_as :default

  require 'twitter'

  def perform
    tweets = get_tweets

	save_tweets(tweets)
  end

  def get_tweets
  	client = Twitter::REST::Client.new do |config|
	    config.consumer_key        = "FZNGD6vxr9Nu12gY3eW2H9ESw"
	    config.consumer_secret     = "cvqlxT79AFw90aJoFkTg5qk9HeY8aHte9ZND4Ie5GhRQb2WLrp"
	    config.access_token        = "1225205197829496838-XZvxdxMoaestlD36U7YVH0yPQFBNG7"
	    config.access_token_secret = "kgsBOK2FtXz3bDXw3NBIQxjXOJmgLlB6J2knhHumVGuNX"
	end

	hashtags = Hashtag.all

	tweets = Hash.new

	hashtags.each do |hashtag|
		tweets[hashtag.id] = client.search("##{hashtag.value}").take(100)
		tweets[hashtag.id] = remove_existing(tweets[hashtag.id])
	end

	tweets
  end

  def remove_existing(tweets)
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

  def save_tweets(messages)
  	messages.each do |hashtag, tweets|
  		tweets.each do |tweet|
			message = Message.new
			message.twitter_id = tweet.id
			message.author = tweet.user.screen_name
			message.body = tweet.text
			message.publication_date = tweet.created_at

			message.save

			hashtag_message = HashtagMessage.new
			hashtag_message.hashtag_id = hashtag
			hashtag_message.message_id = message.id

			hashtag_message.save
		end
	end
  end
end
