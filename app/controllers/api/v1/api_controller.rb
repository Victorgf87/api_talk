

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

  def paginate(scope, default_per_page = 20)
    collection = scope.page(params[:page]).per((params[:per_page] || default_per_page).to_i)

    current, total, per_page = collection.current_page, collection.total_pages, collection.limit_value

    return [ {
                current:  current,
                previous: (current > 1 ? (current - 1) : nil),
                next:     (current == total ? nil : (current + 1)),
                per_page: per_page,
                pages:    total,
                count:    collection.total_count

            }, collection]
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

