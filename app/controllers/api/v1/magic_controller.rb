class Api::V1::MagicController < Api::V1::ApiController
  skip_before_action
  def index
    render json: params
  end

  def show
    render json: request
  end
end