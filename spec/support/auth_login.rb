module AuthHelper
  def http_login(user)
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(user.username,user.password)
  end
end
