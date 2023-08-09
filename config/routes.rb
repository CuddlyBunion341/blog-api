Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'test#index'

  scope '/api' do
    scope '/v1' do
      get 'test', to: 'test#index'

      get '/posts/random', to: 'posts#random'
      resources :posts, only: %i[index show create update destroy] do
        resources :comments, only: %i[index create]
      end

      get '/users/current', to: 'users#current'
      resources :users, only: %i[index show]

      resources :comments, only: %i[create update destroy]

      post '/login', to: 'users/sessions#login'
      delete '/logout', to: 'users/sessions#logout'
      post '/signup', to: 'users/registrations#create'
      get '/user', to: 'users/sessions#user'
    end
  end
end
