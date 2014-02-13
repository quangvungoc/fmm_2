class Admin::PositionsController < ApplicationController
  before_action :admin_user
  
  def index
    @positions = Position.paginate page: params[:page], order: "created_at DESC"
  end

  def new
    @position = Position.new
  end

  def create
    @position = Position.new position_params
    if @position.save 
      flash[:success]="Position created successfully"
      redirect_to admin_positions_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    @position = Position.find params[:id]
  end

  def update
    @position = Position.find params[:id]
    if @position.update_attributes position_params
      flash[:success]="Position info updated successfully"
      redirect_to admin_positions_path
    else
      render 'edit'
    end
  end

  def destroy
    @position = Position.find params[:id]
    if @position.destroy 
      flash.now[:success]="Delete succeeded"
      redirect_to admin_positions_path
    else
      flash.now[:failure]="Delete failed"
      redirect_to admin_positions_path
    end
  end

  private
  def position_params
    params.require(:position).permit(:name, :abbr)
  end
end
