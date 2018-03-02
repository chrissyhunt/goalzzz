class ResultsController < ApplicationController

  def new
    @result = Result.new
  end

  def create
    @result = Result.new(result_params)
    @result.goal_id = params[:goal_id]

    if @result.save
      redirect_to goal_path(Goal.find_by(id: params[:goal_id]))
    else
      render :new
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
end
