class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    authenticate_or_request_with_http_basic('haltalk') do |username,password|
      user = User.find_by_username params[:user_id]
      user && username == user.username && password == user.password
    end
  end
end
