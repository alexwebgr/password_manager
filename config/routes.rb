Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'
  post 'home/handle_upload'
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
