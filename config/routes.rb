Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'test#index'

  scope '/api' do
    scope '/v1' do
      get '/posts/random', to: 'posts#random'
      resources :posts, only: %i[index show create update]

      resources :users, only: %i[index show]
      devise_for :users, controllers: {
        session: 'users/sessions',
        registration: 'users/registrations'
      }
    end
  end
end
