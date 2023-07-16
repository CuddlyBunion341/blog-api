Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'test#index'

  scope '/api' do
    scope '/v1' do
      get '/posts/random', to: 'posts#random'
      resources :posts, only: %i[index show create]

      resources :users, only: %i[index show]
    end
  end
end
