class TripService
    attr_reader :params, :error

    def initialize(params)
        @params = params
    end

    def create_trip
        begin
            params[:description] = trip_description
            Trip.create!(params)
        rescue => e
            @error = e.message
        end
    end

    def trip_description
        OpenWeatherService.new(loc_coords).weather_data
    end

    private

    def loc_coords
        Geocoder.search(params[:city_name]).first.coordinates
    end
end