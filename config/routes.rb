Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  post "bmr", to: "bmrs#calculate"
  get "bmr", to: "bmrs#history"

  get "bmi", to: "bmi#calculate"

  resources :gender

  resources :patients

  # get "patients/index" =>"patients#index"
  # get "patients/show"
  # post "patients/create" =>"patients#create"
  # put "patients/:id" => "patients#update"
  # get "patients/destroy"

  resources :doctors
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
