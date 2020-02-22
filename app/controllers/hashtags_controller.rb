class HashtagsController < ApplicationController
	layout "navbar"

	def index
		@user = User.find(session[:user_id])
	end

	def show
		@user = User.find(session[:user_id])
		@hashtag = @user.hashtags.find(params[:id])
	end

	def new
	end

	def create
		@user = User.find(session[:user_id])
		@hashtag_params = hashtag_parameters
		@hashtag = Hashtag.find_by_value(@hashtag_params[:value])

		if @hashtag.nil?
			@hashtag = @user.hashtags.create(@hashtag_params)
		else
			@user.user_hashtags.create(user_id: session[:user_id], hashtag_id: @hashtag.id)
		end
		redirect_to user_hashtags_path(@user)
	end

	def destroy
		@user = User.find(session[:user_id])
		@id = params[:id]
		@user_hashtag = UserHashtag.find_by(user_id: session[:user_id], hashtag_id: @id)

		@user_hashtag.destroy

		@hashtag = Hashtag.find(@id)

		if @hashtag.users.count == 0
			@hashtag.destroy
		end

		redirect_to user_hashtags_path(@user)
	end

	private 
	def hashtag_parameters
		params.require(:hashtag).permit(:value, :user_id)
	end
end
