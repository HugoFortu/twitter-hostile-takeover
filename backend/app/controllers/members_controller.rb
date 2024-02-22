class MembersController < ApplicationController
  # before_action :authenticate_user!

  def show
    user = get_user_from_token
    render json: {
      message: "Connected",
      user: user
    }
  end

  private

  def get_user_from_token
    p '-----------------------------------------------------'
    p request
    p request.headers['Authorization']
    p '-------------------------------------------------------'
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], ENV['DEVISE_JWT_SECRET_KEY']).first
    user_id = jwt_payload['sub']
    user = User.find(user_id.to_s)
  end
end
