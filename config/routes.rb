Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'purchases#index'
  resources :purchases, except: :show
  resources :categories, except: :show
end
