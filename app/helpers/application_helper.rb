module ApplicationHelper

  #简单加密
  def smile
    SecureRandom.urlsafe_base64
  end

  #flash 提示信息
  def notice_message
    flash_messages = []
    flash.each do |type, message|
      type = :success if type.to_sym == :notice
      type = :danger if type.to_sym == :alert
      text = content_tag(:div, button_tag('×', 'type' => 'button', :class => 'close', 'data-dismiss' => 'alert','aria-hidden' => 'true') + message, class: "alert alert-dismissible alert-#{type}")
      flash_messages << text if message
    end
    flash_messages.join("\n").html_safe
  end

  # markdown语法支持
  class CodeRayify < Redcarpet::Render::HTML
    def block_code(code, language)
      language ||= :plaintext
      CodeRay.scan(code, language).div
    end
  end

  def markdown(text)
    render_options = {
        filter_html:     true,
        hard_wrap:       true,
        link_attributes: { rel: 'nofollow' }
    }
    renderer = CodeRayify.new(render_options)
    extensions = {
        autolink:           true,
        fenced_code_blocks: true,
        lax_spacing:        true,
        no_intra_emphasis:  true,
        strikethrough:      true,
        superscript:        true
    }
    Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
  end

  #多久时间之前
  def time_ago_now(time)
    time = time.iso8601
    '于' + distance_of_time_in_words_to_now(time) + '前发布'
  end

  #用户菜单render
  def render_list(opts = {})
    list = []
    yield(list)
    items = []
    list.each do |link|
      item_class = ""
      urls = link.match(/href=(["'])(.*?)(\1)/) || []
      url = urls.length > 2 ? urls[2] : nil
      if url && current_page?(url) || (@current && @current.include?(url))
        item_class = 'active'
      end
      items << content_tag('li', raw(link), class: item_class)
    end
    content_tag('ul', raw(items.join("")), opts)
  end

  #是否当前用户，是否文章作者
  def owner?(item)
    return false if item.blank? || current_user.blank?
    if item.is_a?(User)
      item.id == current_user.id
    else
      item.user_id == current_user.id
    end
  end

  def birthday_tag
    t = Time.now
    return '' unless t.month == 11 && t.day == 22
    age = t.year - 2011
    title = "德云色 创立 #{age} 周年纪念日"
    html = []
    html << "<div style='text-align:center;margin-bottom:20px; line-height:200%;'>"
    %w(dancers beers cake birthday crown gift crown birthday cake beers dancers).each do |name|
      html << image_tag(asset_path("assets/emojis/#{name}.png"), class: 'emoji', title: title)
    end
    html << '<br />'
    html << title
    html << '</div>'
    raw html.join(' ')
  end

end
