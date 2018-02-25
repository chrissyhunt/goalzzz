class GoalsController < ApplicationController

  def index
    @user = User.find_by(id: params[:user_id])
    @goals = @user.goals
  end

  def show
    @user = User.find_by(id: params[:user_id])
    @goal = Goal.find_by(id: params[:id])
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id

    if @goal.save
      redirect_to goal_path(@goal)
    else
      render :new
    end
  end

  def edit
    @user = User.find_by(id: params[:user_id])
    @goal = Goal.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:user_id])
    @goal = Goal.find_by(id: params[:id])
    @goal.update(goal_params)

    if @goal.save
      redirect_to goal_path(@goal)
    else
      render :edit
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:description, :start_date, :end_date, :interval, :priority, :user_id)
  end
end
