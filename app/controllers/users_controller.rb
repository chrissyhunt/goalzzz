class UsersController < ApplicationController
  before_action :require_login
  skip_before_action :require_login, only: [:index, :new, :create]

  def index
    if logged_in?
      redirect_to user_path(current_user)
    else
      render :index
    end
  end

  def new
    if logged_in?
      redirect_to user_path(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user && @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find_by(id: params[:id])

    if @user != current_user
      redirect_to user_path(current_user)
    else
      render :show
    end
  end

  def edit
    @user = User.find_by(id: params[:id])

    if @user != current_user
      redirect_to user_path(current_user)
    else
      render :edit
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user != current_user
      redirect_to user_path(current_user)
    else
      @user.update(user_params)

      if @user && @user.save
        redirect_to user_path(@user)
      else
        render :edit
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
