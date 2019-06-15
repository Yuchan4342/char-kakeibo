Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'purchase' => 'purchase#index'
  get 'purchase/index'
  get 'purchase/new'
end
