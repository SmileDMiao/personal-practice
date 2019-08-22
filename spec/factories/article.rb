FactoryBot.define do

  factory :article do
    title { 'This is the article rspec' }
    body { 'Test the rspec factory girl rails' }
    association :user
    association :node
  end
  
end
