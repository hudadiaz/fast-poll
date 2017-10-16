class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def current_user force=false
    if session[:uuid] || force
      User.find_or_create_by(uuid: session[:uuid] ||= SecureRandom.uuid)
    end
  end
  helper_method :current_user

  def authenticate_user!
    current_user(true) unless current_user
  end
end
