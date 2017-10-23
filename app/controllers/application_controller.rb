class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :intialize_meta_tags

  def current_user force=false
    if session[:uuid] || force
      User.find_or_create_by(uuid: session[:uuid] ||= SecureRandom.uuid)
    end
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
      description: I18n.t('app.description'),
      image_src: '/logo.png',
      og: {
        site_name: :site,
        image: { _: :image_src },
        title: :title,
        description: :description
      },
      twitter: {
        image: { _: :image_src },
        title: :title,
        description: :description
      }
  end
end
