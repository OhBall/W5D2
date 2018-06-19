Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resource :session
  resources :subs do 
    resources :posts, only: [:new, :create, :show]
  end
  
  resources :posts, only: [:destroy, :edit, :update]
  
  
end
