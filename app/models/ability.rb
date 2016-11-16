class Ability
  include CanCan::Ability

  attr_reader :user

  def initialize(user)
    @user = user
    if user.admin?
      can :manage, :all
    else
      roles_for_members
    end
  end


  protected

  # 普通会员权限
  def roles_for_members
    roles_for_articles
    roles_for_comments
    roles_for_users
  end


  def roles_for_articles
    can [:crete, :favorite, :like, :destroy_like, :destroy_favorite], Article
    can [:update], Article, user_id: user.id
    can [:destroy], Article do |article|
      article.user_id == user.id && article.comments.count == 0
    end
  end

  def roles_for_comments
    can [:create], Comment
    can [:update, :destroy], Comment, user_id: user.id
  end

  def roles_for_users
    can [:update, :destroy], User, id: user.id
  end

end