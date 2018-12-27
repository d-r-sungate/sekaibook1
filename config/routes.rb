Rails.application.routes.draw do

  get 'book/show'
  get 'book/new'
  get 'book/add'

  get '/book', to: 'book#index' ,as: :book_index
  get '/book/:id/comment', to: 'book#comment' ,as: :book_comment
  scope '/book' do
    post '/:id/comment', to: 'book#create'
    patch '/:id/comment', to: 'book#update'
  
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
end
