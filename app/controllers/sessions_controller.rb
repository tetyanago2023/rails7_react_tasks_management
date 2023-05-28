# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      login!
      render json: { logged_in: true, user: @user }
    else
      render json: { status: 401, errors: ['no such user, please try again'] }
    end
  end

  def destroy
    logout!
    render json: { status: 200, logged_out: true }
  end

  def logged_in?
    if logged_in_user? && current_user
      render json: { logged_in: true, user: current_user.attributes }
    else
      render json: { logged_in: false, message: 'no such user' }
    end
  end

  private

  def login!
    session[:user_id] = @user.id
  end

  def logout!
    session.clear
  end

  def logged_in_user?
    session[:user_id].present?
  end

  def session_params
    params.require(:user).permit(:email, :password)
  end
end
