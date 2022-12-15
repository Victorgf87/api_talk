class Api::V1::ApiController < ApplicationController
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  private

  def authenticate
    byebug
    authenticate_or_request_with_http_token do |token, options|
      User.find_by(token: token)
    end
  end
end

# # Path: config/routes.rb
# Rails.application.routes.draw do
#   namespace :api do
#     namespace :v1 do
#       resources :users
#     end
#   end
# end
#
# Now, if you try to access the users index, you will get an error:
#
# $ curl -H "Accept: application/json" http://localhost:3000/api/v1/users
# {"error":"HTTP Token: Access denied."}
#
# We need to pass the token to the request:
#
# $ curl -H