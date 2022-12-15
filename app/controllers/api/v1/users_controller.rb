
# Path: app/controllers/api/v1/users_controller.rb
class Api::V1::UsersController < Api::V1::ApiController
  def index
    render json: User.all
  end
end