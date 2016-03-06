require 'spec_helper'

def valid_params
  {
    username: 'mikekelly',
    password: 'foobarboo'
  }
end


describe UsersController do
  describe "#create" do
    it "should create a new user" do
      expect {
        post :create, valid_params
      }.to change(User, :count).by 1
      response.status.should == 201
      response.headers['Location'].should == user_path(User.first)
    end
  end

  describe "#index" do
    before :each do
      @users = []
      3.times do
        @users << User.create!(valid_params)
      end
    end

    it "should show a list of users" do
      get :index
      assigns(:users).should == @users
    end
  end

  describe "#show" do
    before :each do
      @user = User.create! valid_params
    end

    it "should show a user" do
      get :show, id: @user.username
      assigns(:user).should == @user
    end
  end
end
