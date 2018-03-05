class ResultsController < ApplicationController
  before_action :require_login

  def new
    @goal = Goal.find_by(id: params[:goal_id])

    if @goal.user != current_user
      redirect_to goals_path
    else
      @result = Result.new
    end
  end

  def create
    @goal = Goal.find_by(id: params[:goal_id])

    if @goal.user != current_user
      redirect_to goals_path
    else
      @result = Result.new(result_params)
      @result.goal_id = params[:goal_id]

      if @result.save
        @reflection = Reflection.new(reflection_params)
        @reflection.result_id = @result.id

        if @reflection.save
          redirect_to goal_path(Goal.find_by(id: params[:goal_id]))
        else
          render :new
        end
      else
        render :new
      end
    end
  end

  def edit
  end

  def update
  end

  private

  def result_params
    params.require(:result).permit(:date, :status, :goal_id)
  end

  def reflection_params
    params.require(:result).require(:reflections).permit(:content)
  end
end
