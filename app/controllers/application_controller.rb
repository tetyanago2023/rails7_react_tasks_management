# frozen_string_literal: true

class ApplicationController < ActionController::Base
  skip_before_action :verify_authenticity_token

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def check_project_manager
    return if current_user.project_manager?

    render json: { errors: 'permission denied' }, status: :forbidden
  end
end
