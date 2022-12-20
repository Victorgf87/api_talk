class Api::V1::PostsController < Api::V1::ApiController
  load_and_authorize_resource :post
  wrap_parameters include: [:title, :body]

  def index
    render json: @posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end