module ArticlesHelper

  def like_able_tag(article)
    label = "#{article.likes_count} 个赞"
    title, state, icon_name =
        if article.liked_by_user?(current_user)
          %w(取消赞 active heart)
        else
          ['赞', '', 'heart-o']
        end

    icon = content_tag('i', '', class: "fa fa-#{icon_name}")
    like_label = raw "#{icon} <span>#{label}</span>"

    link_to(like_label, '#', title: title, 'data-count' => article.likes_count,
            'data-state' => state, 'data-type' => article.class, 'data-id' => article.id,
            class: "likeable #{state}")
  end

  def article_favorite_tag(article)
    link_title = '收藏'
    class_name = 'btn btn-default'
    if current_user.favorite_article_ids.include?(article.id)
      class_name = 'active btn btn-default'
      link_title = '取消收藏'
    end

    icon = raw(content_tag('i', '', class: 'fa fa-bookmark'))

    link_to(raw("#{icon} 收藏"), '#', title: link_title, class: "bookmark #{class_name}", 'data-id' => article.id)
  end

  def topic_title_tag(article, opts = {})
    return '文章已经被删除' if article.blank?
      path = article_path(article)
    link_to(article.title, path, title: article.title)
  end

end