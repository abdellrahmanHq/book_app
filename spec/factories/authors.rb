FactoryBot.define do
  factory :author do
    sequence(:name) { |n| "Author #{n}" }
    sequence(:email) { |n| "author#{n}@example.com" }
    password { "123456" }
  end
end