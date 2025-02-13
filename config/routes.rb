# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/webauth/login', to: 'authentication#login', as: 'login'
  get '/webauth/logout', to: 'authentication#logout', as: 'logout'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :channels, only: %i[new create show edit update destroy], param: :channel_id do
    member do
      get :refresh
    end
  end

  resources :videos, only: %i[new create show edit update destroy], param: :video_id

  # Defines the root path route ("/")
  # root "posts#index"
  root "dashboard#show"
  mount MissionControl::Jobs::Engine, at: "/jobs"
end
