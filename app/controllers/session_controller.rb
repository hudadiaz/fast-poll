class SessionController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]

  def new
  end

  def create
    if user = User.find_by(login_params)
      session[:uuid] = user.uuid
    else
      current_user(true)
    end
    redirect_to session[:continue_url] ||= root_path
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
