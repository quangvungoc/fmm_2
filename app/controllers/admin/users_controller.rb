class Admin::UsersController < ApplicationController
  before_action :signed_in_user, :admin_user

  def index
    @teams = Team.all
    if params[:team_id].blank?
      @users = User.paginate page: params[:page], per_page: 5
    else
      @users = Team.find(params[:team_id]).members.paginate page: params[:page], per_page: 5
    end
  end
  
  def new
    @user = User.new
    @positions = Position.all
  end
  
  def create
    @user = User.new user_params|
    if @user.save 
      flash[:success] = "New account was created successfully"
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def destroy
    @user = User.find params[:id]
    if @user.admin?
      flash[:notice] = "User #{@user.name} is an Administrator"
    else 
      @user.destroy
      flash[:success] = "User deleted"
    end
    redirect_to users_url
  end

  private  
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation, :email_confirmation, :remember_token, :birthday, :position_id, 
      :user_skills_atttributes[:id, :skill_id, :level, :used_year_number])
  end
end
