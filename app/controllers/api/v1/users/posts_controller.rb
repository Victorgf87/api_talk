class Api::V1::Users::PostsController < Api::V1::ApiController
  load_and_authorize_resource :user
  load_and_authorize_resource :post, through: :user
  wrap_parameters :post, include: [:title, :body]

  def index
    render json: @user.posts
  end

  def create
    post = @user.posts.create(post_params)
    respond_with :api, :v1, post, location: nil
  end

  def show
    render json: @post
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end