Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'notifications/link_through'
  get 'notifications/:id/link_through', to: 'notifications#link_through', as: :link_through
  get 'likes/create'
  get 'likes/destroy'
  get '/discovers', to: 'discovers#index'
  get '/books/search', to: 'books#search'
  delete 'users/delete/:id', to: 'users#destroy', as: 'users/destroy'
  get '/', to: 'homes#index', as: 'root'
  get '/rule', to: 'homes#rule'
  get '/new_arrival', to: 'homes#new_arrival'
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', :registrations => "users/registrations" }
  resources :users, only: [:show], as: 'users'
  get '/reviews', to: 'reviews#index'
  resources :favorites, only: [:create, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :hashtags
  
  resources :reviews do
    collection do
      post :confirm
    end
    resources :comments
  end
  
  resources :reviewtags
  
  resources :items do
    patch 'update_tags', on: :member
  end

  resources :users, only: [:show] do
    member do
     get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]
end
