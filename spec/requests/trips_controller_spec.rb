# spec/controllers/trips_controller_spec.rb
require 'rails_helper'

RSpec.describe TripsController, type: :controller do
  let(:user) { create(:user) }
  let(:valid_attributes) { attributes_for(:trip) }
  let(:weather_service) { instance_double(OpenWeatherService) }

  describe "GET #index" do
    it "assigns @trips" do
      trip1 = create(:trip, user: user)
      trip2 = create(:trip, user: user)
      get :index, params: {
        email: user.email
      }

      expect(assigns(:trips)).to match_array([trip1, trip2])
    end

    it "renders the index template" do
      get :index, params: {
        email: user.email
      }

      expect(response).to render_template("index")
    end
  end

  describe "GET #new" do
    it "assigns a new Trip as @trip" do
      get :new
      expect(assigns(:trip)).to be_a_new(Trip)
    end
  end

  describe "POST #create" do
    it "creates a new trip with weather details" do
      allow(OpenWeatherService).to receive(:new).and_return(weather_service)
      allow(weather_service).to receive(:get_weather_info).and_return({ "main" => { "feels_like" => 25 } })

      trip_params = { name: "Trip 1", starts_at: Time.now, city_name: "New York" }
      post :create, params: { email: user.email, trip: trip_params }

      expect(response).to redirect_to(trips_path)
      expect(flash[:notice]).to eq("Trip Create Success")
    end
  end

  describe "GET #show" do
    let(:trip) { create(:trip, user: user) }

    it "returns JSON representation of the trip" do
      get :show, params: { id: trip.id }, format: :json

      expect(response).to have_http_status(:success)
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["name"]).to eq(trip.name)
    end
  end

  describe "PATCH #update" do
    let(:user) { create(:user) }
    let(:trip) { create(:trip, user: user) }

    before do
      allow(OpenWeatherService).to receive(:new).and_return(weather_service)
      allow(weather_service).to receive(:get_weather_info).and_return({ "main" => { "feels_like" => 25 } })
    end

    context "with valid attributes" do
      let(:update_params) { attributes_for(:trip, name: "Updated Trip Name") }

      it "updates the trip" do
        patch :update, params: { id: trip.id, email: user.email, trip: update_params }

        expect(response).to redirect_to(trips_path)
        expect(flash[:notice]).to eq("Trip Update Success")
        expect(trip.reload.name).to eq("Updated Trip Name")
      end
    end

    context "with invalid attributes" do
      let(:update_params) { attributes_for(:trip, name: nil) }

      it "does not update the trip" do
        patch :update, params: { id: trip.id, email: user.email, trip: update_params }

        expect(response).to redirect_to(trips_path)
        expect(flash[:alert]).to match(/Error updating trip:/)
        expect(trip.reload.name).not_to be_nil
      end
    end
  end

  describe "DELETE #delete" do
    let(:user) { create(:user) }
    let(:trip) { create(:trip, user: user) }

    context "when trip is successfully deleted" do
      it "redirects to trips index with success notice" do
        delete :destroy, params: {email: user.email, id: trip.id }

        expect(response).to redirect_to(trips_path)
        expect(flash[:notice]).to eq("Trip Deleted Success")
        expect { trip.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
