class SessionsController < ApplicationController

  def create

    # OmniAuth login
    if auth
      @user = User.find_by(email: auth['email'])
      if @user
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        @user = User.create(email: auth['info']['email'], name: auth['info']['name'], password: SecureRandom.urlsafe_base64(n=8))
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      end

    # Normal login
    else
      @user = User.find_by(email: params[:email])

      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
        redirect_to user_path(@user)
      else
        redirect_to root_path
      end
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def auth
    request.env['omniauth.auth']
  end

end
