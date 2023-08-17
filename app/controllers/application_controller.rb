class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :rescue_exception_redirect_to_root
  rescue_from ActionController::ParameterMissing, with: :rescue_exception
  rescue_from ActiveRecord::NotNullViolation, with: :rescue_exception
  rescue_from ArgumentError, with: :rescue_exception
  rescue_from Faraday::ResourceNotFound, with: :rescue_exception

  private

  def rescue_exception(exception)
    flash[:alert] = exception.message
    redirect_back(fallback_location: trips_path)
  end

  def rescue_exception_redirect_to_root(exception)
    flash[:alert] = exception.message
    redirect_back(fallback_location: root_path)
  end
end
