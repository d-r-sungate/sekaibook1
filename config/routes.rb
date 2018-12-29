Rails.application.routes.draw do

  get 'books/add'
  get 'books', to: 'books#index' ,as: :books_index
  get 'books/:id/show', to: 'books#show' ,as: :books_show
  get 'books/:id/comment', to: 'books#comment' ,as: :books_comment
  scope 'books/' do
    post ':id/comment', to: 'books#create'
    patch ':id/comment', to: 'books#update'
  
  end

  
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
  devise_scope :user do
   post 'users/sign_up/confirm' => 'users/registrations#confirm'
   post 'users/sign_up/complete' => 'users/registrations#complete'
  end
  resources :users, :only => [:index, :show, :edit, :update]
  resources :articles, :only => [:index, :create]
  resources :likes, :only => [:create, :destroy]
end
