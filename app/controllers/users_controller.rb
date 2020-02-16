class UsersController < ApplicationController
  
  def new
  end

  def create
  	@user = User.new(user_parameters)

  	if @user.save
  		redirect_to users_path
  	else
  		render 'new'
  	end
  end

  private
  def user_parameters
  	params.require(:user).permit(:username, :password)
  end
end
