class TripsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_trip, only: [:update, :destroy]

  def index
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new
  end

  def create
    city_weather_details = weather_service.get_weather_info

    trip = current_user.trips.build(trip_params)
    trip.destination_details = city_weather_details

    if trip.save
      redirect_to trips_path, notice: 'Trip Create Success'
    else
      flash[:alert] = "Error creating trip: #{trip.errors.full_messages.join(', ')}"
      redirect_to trips_path
    end
  rescue OpenWeather::Errors::Fault => e
    handle_weather_error(e)
  end

  def show
    @trip = Trip.find(params[:id])
    respond_to do |format|
      format.json { render json: @trip }
    end
  end

  def update
    fetch_and_update_weather_details if update_params[:city_name].present?

    if @trip.update(update_params)
      session[:email] = current_user.email
      redirect_to trips_path, notice: 'Trip Update Success'
    else
      flash[:alert] = "Error updating trip: #{@trip.errors.full_messages.join(', ')}"
      redirect_to trips_path
    end
  end

  def destroy
    if @trip.destroy
      redirect_to trips_path, notice: 'Trip Deleted Success'
    else
      flash[:alert] = "Error deleting trip: #{@trip.errors.full_messages.join(', ')}"
      redirect_to trips_path
    end
  end

  private

  def current_user
    @current_user ||= User.find_by(email: params[:email] || session[:email])
  end

  def trip_params
    params.require(:trip).permit(:name, :starts_at, :ends_at, :city_name)
  end

  def update_params
    params.require(:trip).permit(:name, :ends_at, :starts_at, :long, :lat, :status, :city_name)
  end

  def weather_options
    {
      long: params[:long],
      lat: params[:lat],
      city_name: update_params[:city_name] || trip_params[:city_name]
    }
  end

  def weather_service
    OpenWeatherService.new(weather_options)
  end

  def find_trip
    @trip = current_user.trips.find(params[:id])
  end

  def fetch_and_update_weather_details
    city_weather_details = weather_service.get_weather_info
    @trip.destination_details = city_weather_details
  end

  def handle_weather_error(error)
    flash[:alert] = "Error fetching weather data: #{error.message}"
    redirect_to trips_path
  end
end
