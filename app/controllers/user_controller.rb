class UserController < ApplicationController
  before_action :authenticate_user!
  
  def show
  end

  def reset_secret
    current_user.save
    redirect_to user_path
  end

  def merge
    user = User.find_by(user_params)
    if user && user != current_user
      current_user.merge(user)
    end
    redirect_to user_path
  end

  private

  def user_params
    params.require(:user).permit(:secret)
  end
end
