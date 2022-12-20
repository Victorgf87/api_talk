Rails.application.routes.draw do
  apipie
  namespace :api do
    concern :paginatable do
      get '(page/:page)', action: :index, on: :collection, as: ''
    end

    namespace :v1 do
      resources :sessions, only: [:create]
      resources :posts, only: [:index, :show], concerns: :paginatable
      resources :users, only: [:create, :update, :show, :index] do
        resources :posts, controller: 'users/posts', concerns: :paginatable
      end

      match '*unmatched', to: 'api#bad_url', via: [:get, :post]
    end
  end
end
