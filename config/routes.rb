Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
root 'products#index'

resources :products
resources :shopping_carts, only: [:show, :destroy, :create, :update]
resources :line_items
resources :buyers, except: :destroy
resources :sessions, only: [:new, :create, :destroy]

get '/orders', to: 'shopping_carts#orders', as: 'orders'

patch '/reset', to: 'line_items#reset', as: 'reset'
end
