class Api::V1::AuthenticationController < Api::V1::BaseController
  def create
    if user = User.authenticate_user!(auth_params[:email], auth_params[:password])
      render :json => [user]
    else
      render :json => { :error => 'Authentication failed' }
      head 401
    end
  end

private

  def auth_params
    params.require(:user).permit(:email, :password)
  end
end