module UsersHelper

  #查看用户连接
  def user_name_tag(user)
    return '匿名'.freeze if user.blank?
    name = user.full_name
    link_to(name, user_path(user))
  end

  #用户头像链接,user:用户,img_class:class,opts:选项
  def user_avatar_tag(user, img_class, opts = {})
    # return nil unless user
    # image_url = user.avatar.url
    # image = image_tag(image_url, class: img_class)
    #
    # options = {}
    #
    # if opts[:link] != false
    #   link_to(raw(image), user_path(user), options)
    # else
    #   raw image
    # end
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
    login = user.id
    if followed
      link_to raw("#{icon} <span>取消关注</span>"), '#', 'data-id' => login, class: "#{class_names} active"
    else
      link_to raw("#{icon} <span>关注</span>"), '#', 'data-id' => login, class: class_names
    end
  end

end