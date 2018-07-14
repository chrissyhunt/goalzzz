class ResultsController < ApplicationController
  before_action :require_login

  def create
    @goal = Goal.find_by(id: params[:goal_id])

    # Authorization check
    if !authorized?(@goal)
      redirect_to goals_path
    else

      # Build result
      @reflection = Reflection.new(reflection_params)
      @reflection.result_id = params[:result_id]

      if @reflection.save
        render json: @reflection, status: 200
      else
        render :new
      end
    end
  end

  private

  def reflection_params
    params.require(:reflection).permit(:result_id, :content)
  end
end
