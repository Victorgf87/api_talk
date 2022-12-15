Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # Path: config/routes.rb
  Rails.application.routes.draw do
    namespace :api do

      namespace :v1 do
        match '*unmatched', to: 'api#bad_url', via: [:get, :post]
        resources :users
      end
    end
  end
end
