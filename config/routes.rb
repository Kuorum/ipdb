Rails.application.routes.draw do

  resources :permissions
  resources :geo_area_categories
  resources :geo_areas
  resources :political_parties
  resources :regions

  devise_for :users, :controllers => { :registrations => "registrations" }, :skip => [:sessions]
  as :user do
    get 'sign-in' => 'devise/sessions#new', :as => :new_user_session
    post 'sign-in' => 'devise/sessions#create', :as => :user_session
    #get 'users/sign_out' => "devise/sessions#destroy", :as => :destroy_user_session 
    #get '/users/sign_out' => 'sessions#destroy'
    get '/users/sign_out' => 'devise/sessions#destroy'

    get "users/ban/:id" => 'users#ban', :as => "users_ban"
    get "users/unban/:id" => 'users#unban', :as => "users_unban"

    resources :users_admin, :controller => 'users'

  end

  resources :users
  resources :versions

  resources :countries
  get 'home/index'

  resources :data
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  root :to => "regions#index"

   
  #get "home/scrape" => "home#scrape", :as => "scrape"
  get "home/show" => "home#show", :as => "show"
  get "home/edit" => "home#edit", :as => "edit"
  get "data/download" => "data#download", :as => "download"

  get "foo/bar"

  post "process/download_csv" => "process/download_csv", :as => "download_csv"
  get "process/scrape" => "process/scrape", :as => "scrape"

  get "permissions/:id/edit2" => "permissions#edit2", :as => "edit_permission2"
  patch "permissions/:id/update2" => "permissions#update2", :as => "update_permission2"

  
  get "foo/bar", as: "update_text"

  
  get "pages/alliance" => "pages/alliance", :as => "page/alliance"
  get "pages/nation" => "pages/nation", :as => "page/nation"
  get "pages/state" => "pages/state", :as => "page/state"
  get "pages/county" => "pages/county", :as => "page/county"
  get "pages/city" => "pages/city", :as => "page/city"
  
  get "pages/politicians" => "pages/politicians", :as => "page/politicians"
  get "pages/parties" => "pages/parties", :as => "page/parties"




  resources :regions do
    resources :political_parties
  end


end
