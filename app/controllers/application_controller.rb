class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :intialize_meta_tags

  def current_user force=false
    if session[:jwt]
      User.from_jwt_token(session[:jwt])
    elsif force
      user = User.create!
      session[:jwt] = user.jwt_token
      user
    end
  rescue JWT::VerificationError
    session[:jwt] = nil
    nil
  end
  helper_method :current_user

  def authenticate_user!
    unless current_user
      session[:continue_url] = request.original_url
      redirect_to login_path
    end
  end

  def intialize_meta_tags
    set_meta_tags site: I18n.t('app.name'),
      reverse: true,
      separator: '-',
      description: I18n.t('app.description'),
      image_src: "#{root_url}logo.png",
      og: {
        site_name: :site,
        image: { _: :image_src },
        title: :title,
        description: :description
      },
      twitter: {
        card: 'summary',
        image: { _: :image_src },
        title: :title,
        description: :description
      }
  end
end
