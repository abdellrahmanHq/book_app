FactoryBot.define do
  factory :book do
    sequence(:name) { |n| "Book #{n}" }
    release_date { Date.yesterday }
    author
  end
end