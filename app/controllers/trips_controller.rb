class TripsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @trips = current_user.trips

    render json: { trips: @trips }, status: 200
  end

  def create
    current_user.trips.create!(trip_params)

    redirect_to trips_path, notice: 'Trip Create Success'
  end

  def update
    return unless trip
    
    trip.update(update_params)
    session[:email] = current_user.email
    redirect_to trips_path, notice: 'Shipment Update Success'
  end

  def delete
    return unless trip

    trip.delete

    redirect_to trips_path, notice: 'Shipment Deleted Success'
  end

  private

  def current_user
    @current_user ||= User.find_by(email: params[:email] || session[:email])
  end

  def trip_params
    params.require(:trip).permit(:name, :starts_at, :ends_at, destination_details: [:long, :lat])
  end

  def update_params
    params.require(:trip).permit(:name, :ends_at, :starts_at, destination_details: [:long, :lat])
  end

  def trip
    @trip = current_user.trips.find(params[:id])
  end
end
