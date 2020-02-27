class TweetCollectorJob < ApplicationJob
  	queue_as :default

  	def perform
    	Message.get_messages_from_twitter
  	end
end
