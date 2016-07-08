# 添加邮箱验证,并添加错误信息的多语言支持
#rails4中正则的写法要求有些变化，这里需要注意一下
class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    # record.errors[attribute] << (options[:message] || "is not an email") unless
    record.errors.add(attribute,:email)  unless
      value =~ /\A[a-zA-Z0-9.!#$%&'*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*\z/i
  end
end