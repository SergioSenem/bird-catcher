class MessagesController < ApplicationController

	require 'twitter'

	def index

		client = Twitter::REST::Client.new do |config|
	      config.consumer_key        = "FZNGD6vxr9Nu12gY3eW2H9ESw"
	      config.consumer_secret     = "cvqlxT79AFw90aJoFkTg5qk9HeY8aHte9ZND4Ie5GhRQb2WLrp"
	      config.access_token        = "1225205197829496838-XZvxdxMoaestlD36U7YVH0yPQFBNG7"
	      config.access_token_secret = "kgsBOK2FtXz3bDXw3NBIQxjXOJmgLlB6J2knhHumVGuNX"
	    end

		@tweets = client.search("#test").take(100)
	end

end