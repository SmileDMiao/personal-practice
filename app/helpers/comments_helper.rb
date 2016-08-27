module CommentsHelper

  # 评论赞功能
  def comment_like_tag(comment)
    return '' if comment.blank?

    label = "#{comment.likes_count} 个赞"
    label = '' if comment.likes_count == 0

    title, state, icon_name =
        if comment.liked_by_user?(current_user)
          %w(取消赞 active heart)
        else
          ['赞', '', 'heart-o']
        end
    icon = content_tag('i', '', class: "fa fa-#{icon_name}")
    like_label = raw "#{icon} <span>#{label}</span>"

    link_to(like_label, '#', title: title, 'data-count' => comment.likes_count,
            'data-state' => state, 'data-type' => comment.class, 'data-id' => comment.id,
            class: "likeable #{state}")
  end

end