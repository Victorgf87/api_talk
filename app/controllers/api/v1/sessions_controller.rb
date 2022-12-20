class Api::V1::SessionsController < Api::V1::ApiController
  skip_before_action :authenticate

  def create
    user = User.auth_by_mail_and_pass(password_params[:email], password_params[:password])
    if user
      response.headers['token'] = user.auth_token
      head :created
    else
      head :not_found
    end

  end

  def destroy

  end

  private

  def password_params
    params.permit(:email, :password)
  end
end