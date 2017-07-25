FactoryGirl.define do
  factory :review do
    association :user, factory: :user
    association :category, factory: :category
    body Faker::Hacker.say_something_smart
    rating 2
  end
end
