class CommentsController < ApplicationController
    before_action :find_comment, only: [:show, :update, :destroy]

    def index
        @comment = Comment.all
        # include the commenting spots the comment belongs to
        render :json => @comment, 
            include: [
                commented_project:{
                    except: [:id,:created_at, :updated_at]
                    },
                commenter:{
                    except: [:id,:created_at, :updated_at]
                    }], status: :ok
    end

    def create
        @comment = Comment.create(comment_params)
        if @comment.persisted?
            render :json => @comment, include: [:project,:user], status: :created
        else
            render :json => { errors: @comment.errors }
        end
    end

    def show
        if @comment
            render :json => @comment
        else
            render :json => {error: 'Comment not found'}, status: :not_found
        end
    end

    def update
        @comment.update(comment_params)
        if @comment.persisted?
            render :json => @comment, status: :ok
        else
            render :json => { errors: @comment.errors }
        end
    end

    def destroy
        @comment.is_active = false
        if(@comment.save())
            render :json => { :message => "Succesful." }
        end
    end

    private
    def comment_params
        params.require(:comment).permit(:comment,:user_id,:project_id)
    end

    def find_comment
        @comment = Comment.find_by(id: params[:id])
    end

end
