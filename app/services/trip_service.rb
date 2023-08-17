class TripService
    attr_reader :params, :current_user, :error

    def initialize(params, current_user)
        @current_user = current_user
        @params = params
    end

    def create_trip!
        params[:destination_details] = trip_description
        params[:user] = current_user

        Trip.create!(params)
    rescue => e
        @error = e.message
    end

    def update_trip!(trip)
        params[:destination_details] = trip_description
        params[:user] = current_user

        trip.update!(params)
    rescue => e
        @error = e.message
    end

    def trip_description
        @trip_description ||= OpenWeatherService.new(*loc_coords).weather_data
    end

    private

    def loc_coords
        Geocoder.search(params[:city_name].downcase).first.coordinates
    rescue
        raise StandardError, "Invalid city"
    end
end