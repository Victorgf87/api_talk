Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # Path: config/routes.rb
  Rails.application.routes.draw do
    namespace :api do

      namespace :v1 do
        #resources :users
        # match ':resource/:id', to: ':resource#jarl', via: :get

        resources :sessions, only: [:create]
        resources :users, only: [:create, :update, :show, :index]

        match '*unmatched', to: 'api#bad_url', via: [:get, :post]
      end
    end
  end
end
