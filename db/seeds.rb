require 'faker'

5.times do
    user = User.create(
      email: Faker::Internet.email,
      created_at: Faker::Time.between(from: 1.year.ago, to: Time.current),
      updated_at: Faker::Time.between(from: 1.year.ago, to: Time.current)
    )
  
    rand(1..3).times do
      Trip.create(
        destination_details: {
          city: Faker::Address.city,
          country: Faker::Address.country
        }.to_json,
        name: Faker::Lorem.words(number: 2).join(' '),
        starts_at: Faker::Time.between(from: 1.month.from_now, to: 3.months.from_now),
        ends_at: Faker::Time.between(from: 3.months.from_now, to: 6.months.from_now),
        status: ["planned", "in_progress", "completed"].sample,
        user_id: user.id,
        created_at: Faker::Time.between(from: 6.months.ago, to: Time.current),
        updated_at: Faker::Time.between(from: 6.months.ago, to: Time.current)
      )
    end
  end
  
  puts "Seed data created successfully!"
    