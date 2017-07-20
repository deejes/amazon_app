FactoryGirl.define do
  factory :category do
    sequence(:name) {|n| "#{Faker::Hacker.noun} #{n}" }
  end
end
