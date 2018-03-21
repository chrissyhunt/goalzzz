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
          redirect_to goal_path(@goal)
        else
          render :new
        end
      else
        render :new
      end
    end
  end

  def show
    @goal = Goal.find_by(id: params[:goal_id])
    @result = Result.find_by(id: params[:id])

    if @goal.user != current_user
      redirect_to goals_path
    else
      render :show
    end
  end

  def edit
    @goal = Goal.find_by(id: params[:goal_id])
    @result = Result.find_by(id: params[:id])

    if @goal.user != current_user
      redirect_to goals_path
    else
      render :edit
    end
  end

  def update
    @goal = Goal.find_by(id: params[:goal_id])
    @result = Result.find_by(id: params[:id])

    if @goal.user != current_user
      redirect_to goals_path
    else
      @result.update(result_params)
      @reflection = Reflection.find_or_create_by(result_id: @result.id)
      @reflection.update(reflection_params)

      if @result.save && @reflection.save
        redirect_to goal_path(@goal)
      else
        render :edit
      end
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:goal_id])
    @result = Result.find_by(id: params[:id])

    if @goal.user != current_user
      redirect_to goals_path
    else
      @result.delete
      redirect_to goal_path(@goal)
    end
  end

  private

  def result_params
    params.require(:result).permit(:date, :status, :goal_id)
  end

  def reflection_params
    params.require(:result).require(:reflections).permit(:content)
  end
end
