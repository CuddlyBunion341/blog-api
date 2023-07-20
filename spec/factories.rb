FactoryBot.define do
  factory :tag do
    name { 'MyString' }
    description { 'MyString' }
  end

  factory :comment do
    association :author, factory: :user
    body { 'MyText' }
    association :post
  end

  factory :user do
    sequence(:username) { |n| "user#{n}" }
    password { '123456' }
    sequence(:email) { |n| "user#{n}@example.com" }
  end

  factory :post do
    sequence(:title) { |n| "Post #{n}" }
    body { 'Lorem Ipsum...' }
    association :author, factory: :user
  end
end
