module ApplicationHelper
  def session_link
    if current_user
      active_link_to 'Logout', logout_path, method: :delete, class: 'nav-link', wrap_tag: :li, wrap_class: 'nav-item'
    else
      active_link_to 'Login', login_path, class: 'nav-link', wrap_tag: :li, wrap_class: 'nav-item'
    end
  end
end
