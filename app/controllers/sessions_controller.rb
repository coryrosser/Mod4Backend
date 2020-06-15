class Api::V1::SessionsController < ApplicationController

    def create
      @user = User.find_by(username: session_params[:username])
  
      if @user && @user.authenticate(session_params[:password])
        token = JWT.encode({ user_id: @user.id }, ENV['HKEY'])
        render :json => { token: token }, :status => :ok
      else
        render :json => { "msg" => "Something went wrong" }, :status => :bad_request
      end
    end
  
    def destroy
    end
  
    private
    def session_params
      params.require(:user).permit(:username,:password)
    end
  
  end