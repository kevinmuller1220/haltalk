class RootController < ApplicationController
  respond_to :json

  def index
    root = {
      _links: {
        self: { href: '/' },
        curies: [{
          name: 'ht',
          href: 'http://haltalk.herokuapp.com/rels/{rel}',
          templated: true
        }],
        'ht:users' => { href: users_path },
        'ht:signup' =>  { href: signup_path },
        'ht:me' => { href: '/users/{name}', templated: true },
        'ht:latest-posts' => { href: latest_posts_path }
      },
      welcome: 'Welcome to a haltalk server.',
      hint_1: 'You need an account to post stuff..',
      hint_2: 'Create one by POSTing via the ht:signup link..',
      hint_3: 'Click the orange buttons on the right to make POST requests..',
      hint_4: 'Click the green button to follow a link with a GET request..',
      hint_5: 'Click the book icon to read docs for the link relation.'
    }
    respond_with(root) do |format|
      format.json { render json: root }
      format.html { redirect_to '/explorer/browser.html' }
    end
  end
end
