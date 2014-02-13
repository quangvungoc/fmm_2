class Admin::ProjectsController < ApplicationController
  before_action :admin_user

  def show
    @project = Project.find params[:id]
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new project_params
    if @project.save 
      flash[:success] = "Project created successfully"
      render 'new'
    else
      render 'new'
    end
  end

  private
  def project_params
    params.require(:project).permit(:name, :abbr, :team_id,
      :leader_id, :start_date, :end_date)
  end

end
