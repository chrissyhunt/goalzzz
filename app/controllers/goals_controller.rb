class GoalsController < ApplicationController
  before_action :require_login

  def index
  end

  def show
    @goal = Goal.find_by(id: params[:id])

    if @goal.user != current_user
      redirect_to goals_path
    else
      render :show
    end
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
    @goal = Goal.find_by(id: params[:id])

    if @goal.user != current_user
      redirect_to goals_path
    else
      render :edit
    end
  end

  def update
    @goal = Goal.find_by(id: params[:id])

    if @goal.user != current_user
      redirect_to goals_path
    else
      @goal.update(goal_params)

      if @goal.save
        redirect_to goal_path(@goal)
      else
        render :edit
      end
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:description, :start_date, :end_date, :interval, :priority, :user_id)
  end
end
