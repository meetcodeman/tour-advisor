class TripsController < ApplicationController
  skip_before_action :verify_authenticity_token

  before_action :find_trip, only: [:update, :destroy]
  before_action :find_user, except: %i[new show]

  def index
    session[:email] = current_user.email
    @trips = current_user.trips
  end

  def new
    @trip = Trip.new
  end

  def create
    trip_service = TripService.new(trip_params, current_user)
    trip_service.create_trip!

    if trip_service.error
      flash[:alert] = trip_service.error
      render :new
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
    trip_service = TripService.new(trip_params, @trip.user)
    trip_service.update_trip!(@trip)

    unless trip_service.error
      session[:email] = current_user.email
      redirect_to trips_path, notice: 'Trip Update Success'
    else
      flash[:alert] = "Error updating trip: #{@trip.errors.full_messages.join(', ')}"
      redirect_to trips_path
    end
  end

  def destroy
    binding.pry
    if @trip.destroy
      redirect_to trips_path, notice: 'Trip Deleted Success'
    else
      flash[:alert] = "Error deleting trip: #{@trip.errors.full_messages.join(', ')}"
      redirect_to trips_path
    end
  end

  private

  def find_user
    current_user
  end

  def current_user
    @current_user ||= begin
      User.find_or_create_by(email: params[:email] || session[:email])
    end
  end

  def trip_params
    params.require(:trip).permit(:name, :starts_at, :ends_at, :city_name)
  end

  def find_trip
    binding.pry
    @trip = current_user.trips.find(params[:id])
  end

  def fetch_and_update_weather_details
    city_weather_details = weather_service.get_weather_info
    @trip.destination_details = city_weather_details
  end
end
