# spec/factories/trips.rb
FactoryBot.define do
  factory :trip do
    name { Faker::Lorem.word }
    starts_at { Faker::Time.between(from: DateTime.now, to: DateTime.now + 7) }
    ends_at { Faker::Time.between(from: starts_at, to: starts_at + 7) }
    status { 'PLANNED' }
    association :user, factory: :user
    city_name { ['new york', 'los angeles', 'san francisco', 'atlanta'].sample }
  end
end
