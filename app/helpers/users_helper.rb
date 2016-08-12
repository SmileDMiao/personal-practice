module UsersHelper

  #查看用户连接
  def user_name_tag(user)
    return '匿名'.freeze if user.blank?
    name = user.full_name
    link_to(name, user_path(user))
  end

end