require 'stream-chat'
class UsersController < ApplicationController
    before_action :find_user, only: [:show, :update, :destroy]

    def index
        @user = User.all
        render :json => @user.as_json(only: [:banner_img,:name,:username,:bio,:img,:chat_token], 
        include: [projects:{
            except: [:id,:created_at, :updated_at]
            },
            friends:{
                except: [:id,:created_at, :updated_at],
            },
            pending_friends:{
                except: [:id,:created_at, :updated_at],
            },
            comments:{
            except: [:id,:created_at, :updated_at]
            }]), status: :ok
    end

    def create
        client = create_client
        final_params = user_params
        final_params[chat_token] = client.create_token(user_params[:name])
        byebug
        @user = User.create(final_params)
        token = JWT.encode({ user_id: @user.id }, ENV['HKEY'])
        render :json => { token: token, user:@user.as_json(only: [:name,:username,:bio,:img,:chat_token], include: [:projects,:friends,:comments])}, :status => :ok
    end

    def show
        if @user
            render :json => @user.as_json(only: [:name,:username,:bio,:img,:chat_token])
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

    def token
        @user = User.find_by(name: token_params[:name])
        client = create_client
        @user.chat_token = client.create_token(token_params[:name])
        if(@user.save)
            render :json => { :message => "Successful." }
        else
            render :json => { :errors => "Failed." }
        end
    end

    private
    def user_params
        params.require(:user).permit(:name, :username, :bio, :img, :password, :banner_img)
    end

    def token_params
        params.require(:user).permit(:name)
    end

    def find_user
        @user = User.find_by(id: params[:id])
    end

    def create_client
        StreamChat::Client.new(api_key='5cx2ee96rmr9', api_secret='STREAM_SECRET')
    end
end
