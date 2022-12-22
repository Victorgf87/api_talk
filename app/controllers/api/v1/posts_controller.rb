class Api::V1::PostsController < Api::V1::ApiController
  load_and_authorize_resource :post
  #wrap_parameters include: [:title, :body]

  def index
    pagination, @posts = paginate(@posts)

    headers['pagination'] = pagination.to_json

    respond_with :api, :v1, @posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end