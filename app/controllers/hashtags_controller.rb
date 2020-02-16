class HashtagsController < ApplicationController

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
		@hashtag = @user.hashtags.create(hashtag_parameters)

		redirect_to user_hashtags_path(@user)
	end

	def destroy
		@user = User.find(:user_id)
		@hashtag = @user.hashtags.find(params[:id])
		@hashtag.destroy
		redirect_to user_hashtags_path(@user)
	end

	private 
	def hashtag_parameters
		params.require(:hashtag).permit(:value, :user_id)
	end
end
