module ApplicationHelper
  def session_link
    if current_user
      active_link_to t('actions.logout'), logout_path, method: :delete,
        class: 'nav-link', wrap_tag: :li, wrap_class: 'nav-item', data: { confirm: t('hints.user.logout') }
    else
      active_link_to t('actions.login'), login_path, class: 'nav-link', wrap_tag: :li, wrap_class: 'nav-item'
    end
  end
end
