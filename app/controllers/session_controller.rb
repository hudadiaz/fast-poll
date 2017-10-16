class SessionController < ApplicationController
  def new
  end

  def create
    reset_session
    if user = User.find_by(login_params)
      session[:uuid] = user.uuid
      redirect_to root_path
    else
      current_user(true)
      redirect_to user_path
    end
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def login_params
    params.require(:user).permit(:secret)
  end
end
