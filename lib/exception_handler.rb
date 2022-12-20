module ExceptionHandler

  extend ActiveSupport::Concern

  class UrlNotFound < StandardError; end

  # Define custom error subclasses - rescue catches `StandardErrors`
  # class AuthenticationError < StandardError; end
  # class MissingTokenError < StandardError; end
  # class InvalidTokenError < StandardError; end
  # class UnconfirmedAccountError < StandardError; end
  # class DisapprovedAccountError < StandardError; end
  #
  included do
  #   rescue_from ActionController::ParameterMissing, with: :bad_request
  #
  #   rescue_from ExceptionHandler::AuthenticationError, with: :unauthorized
  #   rescue_from ExceptionHandler::MissingTokenError,   with: :unauthorized
  #   rescue_from ExceptionHandler::InvalidTokenError,   with: :unauthorized
  #   rescue_from JWT::ExpiredSignature,                 with: :unauthorized
  #   rescue_from JWT::DecodeError,                      with: :unauthorized
  #   rescue_from JWT::VerificationError,                with: :unauthorized
  #
  #   rescue_from ExceptionHandler::UnconfirmedAccountError, with: :forbidden
  #   rescue_from ExceptionHandler::DisapprovedAccountError, with: :forbidden
  #   rescue_from CanCan::AccessDenied,                      with: :forbidden
  #
  rescue_from UrlNotFound, with: :not_found
  rescue_from ActionController::InvalidAuthenticityToken, with: :unprocessable_entity
  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  #  rescue_from Geocoder::OverQueryLimitError, with: :too_many_requests
  end

  private

  def json_api_error(exception, status_code)
    {
      errors: [
        {
          status: status_code,
          title: exception.class.name,
          detail: exception.message,
          source: request.path
        }
      ]
    }
  end


  Rack::Utils::SYMBOL_TO_STATUS_CODE.select { |_, code| (400..499).cover?(code) }.each do |symbol, status_code|
    define_method(:"#{symbol}") do |exception|
      render json: json_api_error(exception, status_code), status: status_code
    end
  end
end