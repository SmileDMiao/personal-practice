FactoryGirl.define do

  factory :user do
    sequence(:full_name) { |n| "name#{n}" }
    sequence(:email) {|n| "225656565#{n}@qq.com" }
    password 'password'
    password_confirmation 'password'
    language 'zh-CN'
    city 'Shanghai'
  end

end
