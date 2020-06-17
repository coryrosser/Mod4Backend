class UserFriendsController < ApplicationController
    before_action :find_user_friend, only: [:show]

    def index
        @user_friend = UserFriend.all
        # include the user_friending spots the user_friend belongs to
        render :json => @user_friend, include: [:user,:friend], status: :ok
    end

    def create
        final_params={}
        final_params[:user_id] = User.find_by(username: user_friend_params["user_username"]).id
        final_params[:friend_id] = User.find_by(username: user_friend_params["friend_username"]).id
        final_params[:accepted] = user_friend_params["accepted"]
        @user_friend = UserFriend.create(final_params)
        if @user_friend.persisted?
            render :json => @user_friend, 
                include: [
                    user:{
                        except: [:id,:created_at, :updated_at]
                        },
                    friend:{
                        except: [:id,:created_at, :updated_at]
                        }], status: :created
        else
            render :json => { errors: @user_friend.errors }
        end
    end

    def show
        if @user_friend
            render :json => @user_friend
        else
            render :json => {error: 'UserFriend not found'}, status: :not_found
        end
    end

    def update
        user_id = User.find_by(username: user_friend_params["user_username"]).id
        friend_id = User.find_by(username: user_friend_params["friend_username"]).id
        @user_friend = UserFriend.all.find{|uf| uf.user_id == user_id && uf.friend_id == friend_id}
        final_params = {}
        final_params[:user_id] = user_id
        final_params[:friend_id] = friend_id
        final_params[:accepted] = user_friend_params["accepted"]
        @user_friend.update(final_params)
        if @user_friend.persisted?
            render :json => @user_friend, status: :ok
        else
            render :json => { errors: @user_friend.errors }
        end
    end

    def destroy
        user_id = User.find_by(username: user_friend_params["user_username"]).id
        friend_id = User.find_by(username: user_friend_params["friend_username"]).id
        @user_friend = UserFriend.all.find{|uf| uf.user_id == user_id && uf.friend_id == friend_id}
        if(@user_friend.persisted?)
            @user_friend.destroy
            render :json => { :message => "Succesful." }, status: :ok
        else
            render :json => { :error => "User not Found."}, status: :unprocessable_entity
        end
    end

    private
    def user_friend_params
        params.require(:user_friend).permit(:friend_username,:user_username,:accepted)
    end

    def find_user_friend
        @user_friend = UserFriend.find_by(id: params[:id])
    end
end
