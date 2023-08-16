class TripsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :find_trip, only: [:update, :destroy]

  def index
    session[:email] = current_user.email
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new
  end

  def new
    @trip = Trip.new
  end

  def create
    city_weather_details = weather_service.get_weather_info

    trip = current_user.trips.build(trip_params)
    trip.destination_details = city_weather_details

    if trip_service.error
      render :new, alert: trip_service.error
      return
    end

    redirect_to trips_path, notice: 'Trip Create Success'
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
    @current_user ||= User.find_by!(email: params[:email] || session[:email])
  end

  def trip_params
    params.require(:trip).permit(:name, :starts_at, :ends_at, :city_name)
  end

  def update_params
    params.require(:trip).permit(:name, :ends_at, :starts_at, :long, :lat, :status, :city_name)
  end

  def find_trip
    @trip = current_user.trips.find(params[:id])
  end

  def fetch_and_update_weather_details
    city_weather_details = weather_service.get_weather_info
    @trip.destination_details = city_weather_details
  end
end
