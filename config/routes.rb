Rails.application.routes.draw do
  scope :user do
    get :index, to: "user#index", as: :user
    get :edit, to: "user#edit", as: :edit_user
    get :edit_password, to: "user#edit_password", as: :edit_user_password
    put :update, to: "user#update", as: :update_user
    put :update_pssword, to: "user#update_password", as: :update_user_password
  end

  resources :activities do
    member do
      post :register_hit
      post :unregister_hit
    end
  end
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "application#index"
end
