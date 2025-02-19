Rails.application.routes.draw do
  mount MissionControl::Jobs::Engine, at: "/jobs"

  scope "(:locale)", locale: /en|pt/ do
    resources :posts do
      resources :comments, only: %i[ create ]
    end
    resources :users, only: %i[ new create update destroy]
    get "profile" => "users#profile", as: :profile
    get "edit_profile" => "users#edit_profile", as: :edit_profile
    resource :session
    resources :passwords, param: :token
    root "posts#index"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
end
