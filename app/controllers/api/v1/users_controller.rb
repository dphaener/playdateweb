class Api::V1::UsersController < Api::V1::BaseController
  def index
    render :json => User.all
  end

  def create

  end

private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end