class ProjectsController < ApplicationController
    before_action :find_project, only: [:show, :update, :destroy]

    def index
        @project = Project.all
        # include the projecting spots the project belongs to
        render :json => @project, 
        include: [user:{
                except: [:id,:created_at, :updated_at, :password_digest]
                },
            pictures:{
                except: [:id,:created_at, :updated_at]
                }], status: :ok
    end

    def create
        final_params={}
        final_params[:user_id] = User.find_by(username: project_params["username"]).id
        final_params[:name] = project_params["name"]
        final_params[:desc] = project_params["desc"]
        final_params[:video] = project_params["video"]
        final_params[:link] = project_params["link"]
        final_params[:img] = project_params["img"]
        @project = Project.create(final_params)
        if @project.persisted?
            render :json => @project, include: [user:{
                except: [:id,:created_at, :updated_at, :password_digest]
                },
            pictures:{
                except: [:id,:created_at, :updated_at]
                }], status: :ok
        else
            render :json => { errors: @project.errors }
        end
    end

    def show
        if @project
            render :json => @project
        else
            render :json => {error: 'Project not found'}, status: :not_found
        end
    end

    def update
        @project.update(project_params)
        if @project.persisted?
            render :json => @project, status: :ok
        else
            render :json => { errors: @project.errors }
        end
    end

    def destroy
        @project.is_active = false
        if(@project.save())
            render :json => { :message => "Succesful." }
        end
    end

    private
    def project_params
        params.require(:project).permit(:name,:username,:desc,:video,:link,:img)
    end

    def find_project
        @project = Project.find_by(id: params[:id])
    end
end
