Rails.application.routes.draw do
  apipie
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # Path: config/routes.rb
    namespace :api do

      namespace :v1 do
        resources :sessions, only: [:create]
        resources :posts, only: [:index, :show]
        resources :users, only: [:create, :update, :show, :index] do
          resources :posts, controller: 'users/posts'
        end

        match '*unmatched', to: 'api#bad_url', via: [:get, :post]
      end
    end
end
