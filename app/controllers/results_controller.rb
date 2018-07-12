class ResultsController < ApplicationController
  before_action :require_login

  def new
    @goal = Goal.find_by(id: params[:goal_id])

    # Authorization check
    if !authorized?(@goal)
      redirect_to goals_path
    else
      @result = Result.new
      @result.reflections.build()
    end
  end

  def create
    @goal = Goal.find_by(id: params[:goal_id])

    # Authorization check
    if !authorized?(@goal)
      redirect_to goals_path
    else

      # Build result
      @result = Result.new(result_params)
      @result.goal_id = params[:goal_id]

      if @result.save
        render json: @result, status: 200
      else
        render :new
      end
    end
  end

  def show
    @goal = Goal.find_by(id: params[:goal_id])
    @result = Result.find_by(id: params[:id])

    # Authorization check
    if !authorized?(@goal)
      redirect_to goals_path
    else
      render :show
    end
  end

  def edit
    @goal = Goal.find_by(id: params[:goal_id])
    @result = Result.find_by(id: params[:id])
    if @result.reflections.blank?
      @result.reflections.build()
    end

    # Authorization check
    if !authorized?(@goal)
      redirect_to goals_path
    else
      render :edit
    end
  end

  def update
    @goal = Goal.find_by(id: params[:goal_id])
    @result = Result.find_by(id: params[:id])

    # Authorization check
    if !authorized?(@goal)
      redirect_to goals_path
    else
      @result.update(result_params)

      # Update result
      if @result.save
        render json: @result, status: 200
      else
        render :edit
      end
    end
  end

  def destroy
    @goal = Goal.find_by(id: params[:goal_id])
    @result = Result.find_by(id: params[:id])

    # Authorization check
    if !authorized?(@goal)
      redirect_to goals_path
    else
      @result.delete
      redirect_to goal_path(@goal)
    end
  end

  private

  def result_params
    params.require(:result).permit(:date, :status, :goal_id, reflections_attributes: [:id, :content])
  end

end
