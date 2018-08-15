Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  get 'users/index'
  get 'users/show'
  delete 'users/delete/:id', to: 'users#destroy', as: 'users/destroy'
  get '/', to: 'homes#index', as: 'root'   #追記する
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :users, :only => [:index, :show]
  get '/reviews', to: 'reviews#index'
  resources :favorites, only: [:create, :destroy]
  resources :reviews do
    collection do
      post :confirm
    end
  end
end
