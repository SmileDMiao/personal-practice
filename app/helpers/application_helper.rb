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



end
