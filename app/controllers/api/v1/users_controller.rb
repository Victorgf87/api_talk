
# Path: app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < Api::V1::ApiController
  load_and_authorize_resource

  def index
    render json: User.all
  end

  def create
    render json: User.all
  end
end