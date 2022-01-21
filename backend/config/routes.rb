Rails.application.routes.draw do
  
  scope :api, defaults: {format: :json} do
    resources :posts
    resources :comments
    devise_for :users, controllers: {sessions: 'sessions'}
    devise_scope :user do
      get 'users/current', to: 'sessions#show'
    end
  end

  mount ActionCable.server => '/cable'
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
