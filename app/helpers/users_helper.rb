module UsersHelper

  #查看用户连接
  def user_name_tag(user)
    return '匿名'.freeze if user.blank?
    name = user.full_name
    link_to(name, user_path(user))
  end

  #是否屏蔽该用户
  def block_user_tag(user)
    return '' if current_user.blank?
    return '' if user.blank?
    return '' if current_user.id == user.id
    blocked = 1
    class_names = 'button-block-user btn btn-default btn-block'
    icon = '<i class="fa fa-eye-slash"></i>'
    if blocked
      link_to raw("#{icon} <span>取消屏蔽</span>"), '#', title: '忽略后，社区首页列表将不会显示此用户发布的内容。', 'data-id' => user.full_name, class: "#{class_names} active"
    else
      link_to raw("#{icon} <span>屏蔽</span>"), '#', title: '', 'data-id' => user.full_name, class: class_names
    end
  end

  #是否follow了这个用户
  def follow_user_tag(user, opts = {})
    return '' if current_user.blank?
    return '' if user.blank?
    return '' if current_user.id == user.id
    followed = current_user.followed?(user)
    opts[:class] ||= 'btn btn-primary btn-block'
    class_names = "button-follow-user #{opts[:class]}"
    icon = '<i class="fa fa-user"></i>'
    login = user.full_name
    if followed
      link_to raw("#{icon} <span>取消关注</span>"), '#', 'data-id' => login, class: "#{class_names} active"
    else
      link_to raw("#{icon} <span>关注</span>"), '#', 'data-id' => login, class: class_names
    end
  end

end