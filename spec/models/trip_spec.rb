# spec/models/trip_spec.rb
require 'rails_helper'
require 'rspec/rails'

RSpec.describe Trip, type: :model do
  describe "validations" do
    it 'cannot have trip without starts_at' do 
      expect { Trip.create!(name: 'Trip 1', city_name: 'New York') }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'cannot have trip without starts_at' do 
      expect { Trip.create!(name: 'Trip 2', starts_at: DateTime.now) }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'Trip must be created' do 
      user = User.create!(email: 'test@email.com')
      expect {
        Trip.create!(name: 'Trip 2', starts_at: DateTime.now, city_name: 'New York', user: user)
      }.to change(Trip, :count).by(1)
    end
  end

  describe "enum status" do
    it "has the correct enum values" do
      expect(Trip.statuses).to eq(
        'PLANNED' => 'PLANNED',
        'ONGOING' => 'ONGOING',
        'DELAYED' => 'DELAYED',
        'CANCELLED' => 'CANCELLED'
      )
    end

    it "defines enum methods" do
      trip = Trip.new(status: :PLANNED)
      expect(trip.status).to eq "PLANNED"
    end
  end
end
