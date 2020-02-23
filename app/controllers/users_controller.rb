class UsersController < ApplicationController
    layout "navbar"
  
    def index
        @current_user = User.find(session[:user_id])
        @users = User.all
    end

    def show
        @current_user = User.find(session[:user_id])
        @user = User.find(params[:id])
    end 

    def new
        @current_user = User.find(session[:user_id])
        @url = users_path
        @method = :post
    end

    def edit
        @current_user = User.find(session[:user_id])
        @user = User.find(params[:id])
        @url = user_path(@user)
        @method = :put
    end

    def create
        @current_user = User.find(session[:user_id])
        parameters = user_parameters

        if parameters[:password] == parameters[:password_repeat]
            password_digest = BCrypt::Password.create(parameters[:password])
            User.create(username: parameters[:username], password_digest: password_digest)
            
            redirect_to users_path
        else
            @password_error = true
            render 'new'
        end
    end

    def update
        parameters = user_parameters
        if parameters[:password] == parameters[:password_repeat]
            password_digest = BCrypt::Password.create(parameters[:password])
            @user = User.find(params[:id])
            @user.update!(username: parameters[:username], password_digest: password_digest)

            redirect_to users_path
        else
            @password_error = true
            render 'edit'
        end
    end

    def destroy
        user = User.find(params[:id])
        user.destroy

        redirect_to users_path
    end

    private
    def user_parameters
        params.permit(:username, :password, :password_repeat)
    end
end
