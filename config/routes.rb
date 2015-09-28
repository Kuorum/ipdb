Rails.application.routes.draw do

devise_for :users, :skip => [:sessions]
  as :user do
    get 'sign-in' => 'devise/sessions#new', :as => :new_user_session
    post 'sign-in' => 'devise/sessions#create', :as => :user_session
    #get 'users/sign_out' => "devise/sessions#destroy", :as => :destroy_user_session 
    #get '/users/sign_out' => 'sessions#destroy'
    get '/users/sign_out' => 'devise/sessions#destroy'

  end


  resources :countries
  get 'home/index'

  resources :data
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root :to => "home#index"

   
  get "home/scrape" => "home#scrape", :as => "scrape"
  get "home/show" => "home#show", :as => "show"
  get "home/edit" => "home#edit", :as => "edit"
  get "data/download" => "data#download", :as => "download"

end
