

class Api::V1::ApiController < ApplicationController
  include ActionController::MimeResponds
  include ExceptionHandler
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate, except: [:bad_url]
  skip_before_action :verify_authenticity_token

  respond_to :json

  def current_user
    @current_user ||= authenticate
  end

  def bad_url
    raise UrlNotFound.new I18n.t('url_not_found')
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      user = User.find_by_auth_token(token)
      raise AuthenticationError.new I18n.t('wrong_token') unless user
      user
    end
  end
end

