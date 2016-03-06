class PostsController < ApplicationController
  before_filter :authorize, only: :create

  respond_to :json

  def create
    @user = User.find_by_username params[:user_id]

    @post = @user.posts.create(content: params[:content], in_reply_to: params['in-reply-to'])

    render nothing: true, status: 201, location: post_path(@post)
  end

  def index
    @user = User.find_by_username params[:user_id]
    @posts = @user.posts

    res = {
      _links: {
        self: { href: user_posts_path(@user) },
        curies: [{
          name: 'ht',
          href: 'http://haltalk.herokuapp.com/rels/{rel}',
          templated: true
        }],
        'ht:author' => { href: user_path(@user) }
      },
      _embedded: {
        'ht:post' => []
      }
    }

    @posts.each do |post|
      res[:_embedded]['ht:post'] << post.as_json(nil)
    end

    respond_with res
  end

  def show
    @post = Post.find params[:id]
    respond_with @post
  end

  def latest
    @posts = Post.all
    res = {
      _links: {
        curies: [{
          name: 'ht',
          href: 'http://haltalk.herokuapp.com/rels/{rel}',
          templated: true
        }],
        self: { href: latest_posts_path }
      },
      _embedded: {
        'ht:post' => @posts
      }
    }
    respond_with res
  end
end
