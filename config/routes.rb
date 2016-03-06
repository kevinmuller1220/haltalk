Haltalk::Application.routes.draw do

  get '/posts/latest', to: 'posts#latest', as: :latest_posts

  resources :users, except: :create do
    resources :posts, shallow: true
  end

  post :signup, to: 'users#create'

  get '/rels/:rel', to: 'rels#show'

  root :to => 'root#index'
end
