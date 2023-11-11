class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :basic_auth if Rails.env.production?
  before_action :login_required

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]
    end
  end

  def login_required
    redirect_to new_session_path unless current_user
  end
end
