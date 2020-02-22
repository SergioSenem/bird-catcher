class SessionsController < ApplicationController
  
  skip_before_action :authorized, only: [:new, :create, :welcome]	

  def new
  end

  def create
  	@user = User.find_by_username(params[:username])

  	if @user && @user.authenticate(params[:password])
  		session[:user_id] = @user.id
  		redirect_to user_hashtags_path(@user)
  	else
  		@login_error = true
  		render 'new'
  	end
  end

  def end
    session.delete(:user_id)
    redirect_to root_path
  end
end
