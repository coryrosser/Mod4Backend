class PicturesController < ApplicationController
    before_action :find_picture, only: [:show, :update, :destroy]

    def index
        @picture = Picture.all
        # include the pictureing spots the picture belongs to
        render :json => @picture, 
            include: project:{
                except: [:id,:created_at, :updated_at]
                }, status: :ok
    end

    def create
        @picture = Picture.create(picture_params)
        if @picture.persisted?
            render :json => @picture, include: :project, status: :created
        else
            render :json => { errors: @picture.errors }
        end
    end

    def show
        if @picture
            render :json => @picture
        else
            render :json => {error: 'Picture not found'}, status: :not_found
        end
    end

    def update
        @picture.update(picture_params)
        if @picture.persisted?
            render :json => @picture, status: :ok
        else
            render :json => { errors: @picture.errors }
        end
    end

    def destroy
        @picture.is_active = false
        if(@picture.save())
            render :json => { :message => "Succesful." }
        end
    end

    private
    def picture_params
        params.require(:picture).permit(:img,:project_id)
    end

    def find_picture
        @picture = Picture.find_by(id: params[:id])
    end
end
