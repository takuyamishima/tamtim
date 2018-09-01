Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  delete 'users/delete/:id', to: 'users#destroy', as: 'users/destroy'
  get '/', to: 'homes#index', as: 'root'   #追記する
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', :registrations => "users/registrations" }
  resources :users, only: [:index, :show], as: 'users'
  get '/reviews', to: 'reviews#index'
  resources :favorites, only: [:create, :destroy]
  resources :reviews do
    collection do
      post :confirm
    end
  end
  
  resources :users do
    member do
     get :following, :followers
    end
  end
  resources :relationships,       only: [:create, :destroy]
  
  resources :reviews do
    resources :comments
  end
  
end
