class Admin::TeamsController < ApplicationController
  before_action :signed_in_user, :admin_user

  def index
    @teams = Team.all.paginate page: params[:page]
  end

  def show
    @team = Team.find params[:id]
  end

  def new
    @team = Team.new
  end

  def create
    begin
      Team.transaction do 
        @team = Team.create! team_params
        User.transaction do
          @user = User.find @team.leader_id
          @user.update_attributes! team_id: @team.id
        end
        flash[:success] = "Team created successfully"
        redirect_to [:admin, Team]
      end
    rescue => e
      flash.now[:error] = "Error!!!"
      render 'new'
    end
  end

  def edit
    @team = Team.find params[:id]
    unless params[:user_id].nil?
      @user = User.find params[:user_id]
      @team.members << @user
      if @team.save
        respond_to do |format|
          format.js {render partial: 'add_remove_members'}
        end
      end
    end
  end

  def update
  end

  def destroy
    @team = Team.find params[:id]
    if params[:user_id].nil?     
      if @team.destroy
        flash[:success] = "deleted"
      else
        flash[:error] = "Cannot delete"
      end
      redirect_to [:admin, @team]
    else
      if @team.members.delete User.find(params[:user_id])
        respond_to do |format|
          format.js {render partial: 'add_remove_members'}
        end
      else
        flash[:error] = "cannot remove member"
      end
    end
  end

  private
  def team_params
    params.require(:team).permit(:name, :desc, :leader_id)
  end
end