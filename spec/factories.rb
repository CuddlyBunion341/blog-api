FactoryBot.define do
  factory :tag do
    name { 'MyString' }
    description { 'MyString' }
  end

  factory :comment do
    author { FactoryBot.create(:user) }
    body { 'MyText' }
    post { FactoryBot.create(:post) }
  end

  factory :user do
    username { 'test' }
    password { '123456' }
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body { 'Lorem Ipsum...' }
    author { FactoryBot.create(:user) }
  end
end
