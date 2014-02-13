class UsersController < ApplicationController
  before_action :correct_user, only: [:edit, :update]
  def index
    if params[:team_id].nil?
      @users = User.all
    else
      @users = Team.find(params[:team_id]).members.paginate page:
        params[:page], per_page: 5
    end

    respond_to do |format|
      format.json {render json: @users}
    end
  end

  def show
    @user = User.find params[:id]
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      @message = "Update successfully!"
    else
      @message = "Error!!!"
    end
    respond_to do |format|
      format.js 
      format.html 
    end
  end

  private  
  def user_params
    params.require(:user).permit(:name, :email, :password,
      :password_confirmation, :email_confirmation, :remember_token, :birthday)
  end

  def correct_user
    @user = User.find params[:id]
    redirect_to root_url unless current_user? @user
  end

end
