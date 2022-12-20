class Api::V1::ApiController < ApplicationController
  include ActionController::MimeResponds
  include ExceptionHandler
  include ActionController::HttpAuthentication::Token::ControllerMethods

  skip_before_action :verify_authenticity_token

  before_action :authenticate, except: [:bad_url]
  respond_to :json

  def bad_url
    raise UrlNotFound.new I18n.t('url_not_found')
  end

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      User.find_by(token: token)
    end
  end
end
