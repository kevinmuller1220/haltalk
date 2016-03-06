require 'spec_helper'

def valid_content
  {
    content: 'omg microblog post'
  }
end

describe PostsController do
  before :each do
    @user = User.create({ username: 'mike', password: 'foo' })
  end
  describe "#create" do
    include AuthHelper

    before :each do
      http_login @user
    end

    it "should create a new post" do
      expect {
        post :create, valid_content.merge({ user_id: @user.username })
      }.to change(Post, :count).by 1
      @post = Post.first
      response.status.should == 201
      response.headers['Location'].should == post_path(@post)
      @post.user.should == @user
    end
  end

  describe "#index" do
    before :each do
      @posts = []
      3.times do
        @posts << @user.posts.create(valid_content)
      end
    end

    it "should expose a list of posts" do
      get :index, user_id: @user.username
      assigns(:posts).should == @posts
    end
  end

  describe "#show" do
    before :each do
      @post = @user.posts.create({ content: 'foo' })
    end

    it "should show a post resource" do
      get :show, id: @post.id
      assigns(:post).should == @post
    end
  end

  describe "#latest" do
    before :each do
      @posts = []
      3.times do
        @posts << @user.posts.create(valid_content)
      end
      @user_two = User.create({ username: 'bar', password: 'foo' })
      3.times do
        @posts << @user_two.posts.create(valid_content)
      end
    end

    it "should show the latest posts" do
      get :latest
      assigns(:posts).should == @posts
    end
  end
end
