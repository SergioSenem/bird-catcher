class HashtagsController < ApplicationController
	layout "navbar"

	def index
		@current_user = current_user
	end

	def show
		@current_user = current_user
		@hashtag = @current_user.hashtags.find(params[:id])
	end

	def new
	end

	def create
		@current_user = current_user
		@hashtag_params = hashtag_parameters
		@hashtag = Hashtag.find_by_value(@hashtag_params[:value])

		if @hashtag.nil?
			@hashtag = @current_user.hashtags.create(@hashtag_params)
		else
			@current_user.user_hashtags.create(user_id: session[:user_id], hashtag_id: @hashtag.id)
		end

		Message.get_hashtag_messages_from_twitter(@hashtag)

		redirect_to user_hashtags_path(@current_user)
	end

	def destroy
		@current_user = current_user
		@id = params[:id]
		@user_hashtag = UserHashtag.find_by(user_id: session[:user_id], hashtag_id: @id)

		@user_hashtag.destroy

		@hashtag = Hashtag.find(@id)

		if @hashtag.users.count == 0
			@hashtag.destroy
		end

		redirect_to user_hashtags_path(@current_user)
	end

	private 
	def hashtag_parameters
		params.require(:hashtag).permit(:value, :user_id)
	end
end
