class BootstrapFormBuilder < ActionView::Helpers::FormBuilder

  delegate :content_tag, :javascript_tag, to: :@template

  alias_method :native_text_field,:text_field

  # text field, text area , password field
  # 用法同官方标准: text_field
  %w[text_field text_area password_field].each do |method_name|
    define_method(method_name) do |name, *args|
      content_tag :div, class: 'form-group' do
        label(name, class: 'col-sm-3 control-label') +
            content_tag(:div, class: 'col-sm-6') do
              super(name, *args)
            end
      end
    end
  end

  # BootstrapDateTimePicker 支持参数(:minView,:format)
  # id: 生成的html元素的id,
  # minView =2 format: yyyy-mm-dd; minView = 0 format: yyyy-mm-dd hh:ii
  def date_field(name, *args)
    options = args[0]
    options[:id] ||= @object.class.name.downcase + "_#{name}"
    options[:minView] ||= 2
    script = %Q(
         $(document).ready(function () {
             initBootstrapDateTimePicker("#{options[:id]}",#{options[:minView]});
         });
      )
    content_tag :div, class: 'form-group' do
      label(name, class: 'control-label col-sm-3') +
          content_tag(:div, class: 'col-sm-6') do
            content_tag :div, class: 'input-group' do
              native_text_field(name, *args) + javascript_tag(script) +
                content_tag(:span, class: 'input-group-addon') do
                  content_tag('i',:class => 'fa fa-calendar'){}
                end
            end
          end
    end
  end

  # 日期范围选择：Bootstrap-daterange-picker
  # id: 生成html元素id
  # time: false 不现实小时分钟， time: true 显示小时分钟
  def date_range_field(name, *args)
    options = args[0]
    options[:id] ||= @object.class.name.downcase + "_#{name}"
    options[:time] ||= false
    script = %Q(
         $(document).ready(function () {
             initBootstrapDateRangePicker("#{options[:id]}",#{options[:time]});
         });
      )
    content_tag :div, class: 'form-group' do
      label(name, class: 'control-label col-sm-3') +
          content_tag(:div, class: 'col-sm-6') do
            content_tag :div, class: 'input-group' do
              native_text_field(name, *args) + javascript_tag(script) +
                  content_tag(:span, class: 'input-group-addon') do
                    content_tag('i',:class => 'fa fa-calendar'){}
                  end
            end
          end
    end
  end

  # time field : bootstrap-time-picker
  # only select time /H:M:S
  def time_field(name, *args)
    options = args[0]
    options[:id] ||= @object.class.name.downcase + "_#{name}"
    script = %Q(
         $(document).ready(function () {
             initBootstrapTimePicker("#{options[:id]}");
         });
      )
    content_tag :div, class: 'form-group' do
      label(name, class: 'control-label col-sm-3') +
          content_tag(:div, class: 'col-sm-6') do
            content_tag :div, class: 'input-group bootstrap-timepicker' do
              native_text_field(name, *args) + javascript_tag(script) +
                  content_tag(:span, class: 'input-group-addon') do
                    content_tag('i',:class => 'fa fa-clock-o'){}
                  end
            end
          end
    end
  end

  # select
  # default html_options: {:class 'form-control select2', multiple:"multiple"}
  # class:select2    /chosen select
  # multiple:'multiple'    /select can multiple chosen
  def select(method, choices = nil, options = {}, html_options = {}, &block)
    html_options[:class] ||= 'form-control select2'
    content_tag :div, class: 'form-group' do
      label(method, class: 'col-sm-3 control-label') +
          content_tag(:div, class: 'col-sm-6') do
            super(method, choices, options, html_options, &block)
          end
    end
  end

  # 提交按钮
  def submit(*tag_value)
    content_tag(:div, class: 'form-group') do
      content_tag(:div, class: 'col-sm-6 col-sm-offset-3') do
        super
      end
    end
  end

end