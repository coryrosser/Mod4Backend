class UsersController < ApplicationController
    before_action :find_user, only: [:show, :update, :destroy]

    def index
        @user = User.all
        # include the usering spots the user belongs to
        render :json => @user, include: [:projects,:friends,:comments], status: :ok
    end

    def create
        @user = User.create(user_params)
        byebug
        if @user.persisted?
            render :json => @user, include: [:projects,:friends,:comments], status: :created
        else
            render :json => { errors: @user.errors }
        end
    end

    def show
        if @user
            render :json => @user
        else
            render :json => {error: 'User not found'}, status: :not_found
        end
    end

    def update
        @user.update(user_params)
        if @user.persisted?
            render :json => @user, status: :ok
        else
            render :json => { errors: @user.errors }
        end
    end

    def destroy
        @user.is_active = false
        if(@user.save())
            render :json => { :message => "Succesful." }
        end
    end

    private
    def user_params
        params.require(:user).permit(:name,:username,:bio,:img)
    end

    def find_user
        @user = User.find_by(id: params[:id])
    end
end
