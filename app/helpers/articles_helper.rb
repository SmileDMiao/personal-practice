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
end