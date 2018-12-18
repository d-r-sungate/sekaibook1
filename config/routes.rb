Rails.application.routes.draw do

  get 'book/show'
  get 'book/new'
  get 'book/create'
  get 'book/add'
  get 'book/comment'
  
  get 'about' , to: 'about#show'
  get 'privacy', to: 'about#privacy'
  get 'terms', to: 'about#terms'
  get 'output', to: 'about#output'
  get 'input', to: 'about#input'

  get 'toppages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root to: 'toppages#index'

  devise_for :users, controllers: { 
    :omniauth_callbacks => "omniauth_callbacks"
  }

end
