# RailsSettings Model
class Setting < RailsSettings::Base
  cache_prefix { "v1" }

  field :admin_emails, type: :array, default: ['m8023zsm@live.com']
  field :github_token, default: "91726ee4170d8e2679ec"
  field :github_secret, default: "13c7e55e8e53c57a399181e96ea3a55a3fdd9c7c"

  field :tips, type: :array, default: [
  '你从树上下来吧，我们再也不改需求了',
  '如果你不装比，我就原谅你'
  ]
end
