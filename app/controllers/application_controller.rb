class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_exception
    rescue_from ActionController::ParameterMissing, with: :rescue_exception
    rescue_from ActiveRecord::NotNullViolation, with: :rescue_exception
    rescue_from ArgumentError, with: :rescue_exception

    private

    def rescue_exception(exception)
        redirect_to trips_path, alert: exception.message, status: :not_found
    end
end
