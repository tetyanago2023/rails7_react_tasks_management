# frozen_string_literal: true

class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: session_params[:email])

    if @user&.authenticate(session_params[:password])
      login!
      render json: { logged_in: true, user: @user.attributes.except('password_digest') }, status: 201
    else
      render json: { errors: ['no such user, please try again'] }, status: 401
    end
  end

  def destroy
    logout!
    render json: { logged_out: true }, status: 200
  end

  def logged_in?
    if logged_in_user? && current_user
      render json: { logged_in: true, user: current_user.attributes.except('password_digest') }
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
