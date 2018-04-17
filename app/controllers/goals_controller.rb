class GoalsController < ApplicationController
  before_action :require_login

  def index
    @high_priority_goals = current_user.goals.where(priority: 'high')
    @medium_priority_goals = current_user.goals.where(priority: 'medium')
    @low_priority_goals = current_user.goals.where(priority: 'low')
  end

  def completed
    @high_priority_goals = Goal.completed.select { |g| g.user_id == current_user.id && g.priority == "high" }
    @medium_priority_goals = Goal.completed.select { |g| g.user_id == current_user.id && g.priority == "medium" }
    @low_priority_goals = Goal.completed.select { |g| g.user_id == current_user.id && g.priority == "low" }
  end

  def show
    @goal = Goal.find_by(id: params[:id])

    # Authorization check
    if !authorized?(@goal)
      redirect_to goals_path
    else
      @goal_reflections = @goal.reflections.sort_by { |refl| refl.result.date }
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

    # Authorization check
    if !authorized?(@goal)
      redirect_to goals_path
    else
      render :edit
    end
  end

  def update
    @goal = Goal.find_by(id: params[:id])

    # Authorization check
    if !authorized?(@goal)
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

  def destroy
    @goal = Goal.find_by(id: params[:id])

    # Authorization check
    if authorized?(@goal)
      @goal.delete
      redirect_to goals_path
    else
      redirect_to go goals_path
    end
  end

  private

  def goal_params
    params.require(:goal).permit(:description, :start_date, :end_date, :interval, :priority, :user_id)
  end
end
