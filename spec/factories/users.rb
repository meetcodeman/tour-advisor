# spec/factories/users.rb
FactoryBot.define do
    factory :user do
      email { Faker::Internet.email }
    end
  end
  