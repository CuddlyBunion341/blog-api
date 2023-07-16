FactoryBot.define do
  factory :comment do
    author { FactoryBot.create(:user) }
    body { 'MyText' }
    post { FactoryBot.create(:post) }
  end

  factory :user do
    username { 'test' }
    password { 'test' }
    email { 'test@example.com' }
  end

  factory :post do
    title { 'Hello World!' }
    content { 'Lorem Ipsum...' }
    user { FactoryBot.create(:user) }
  end
end
