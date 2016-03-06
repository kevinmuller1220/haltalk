class UsersController < ApplicationController
  respond_to :json

  def create
    @user = User.create params.slice :username, :password, :real_name
    if @user.valid?
      render nothing: true, status: 201, location: user_path(@user)
    else
      render json: { errors: @user.errors }, status: 400
    end
  end

  def index
    @users = User.all
    res = {
      _links: {
        self: { href: users_path },
        curies: [{
          name: 'ht',
          href: 'http://haltalk.herokuapp.com/rels/{rel}',
          templated: true
        }],
        'ht:user' => []
      }
    }
    @users.each do |user|
      res[:_links]['ht:user'] << { href: user_path(user), title: user.real_name }
    end
    respond_with res
  end

  def show
    @user = User.find_by_username params[:id]
    respond_with @user
  end
end
