# frozen_string_literal: true

Rails.application.routes.draw do
  post '/login',    to: 'sessions#create'
  post '/logout',   to: 'sessions#destroy'
  get '/logged_in', to: 'sessions#logged_in?'

  namespace :api do
    resources :projects, except: %i[new edit]
    resources :employees, only: %i[index create]
    resources :tasks, only: %i[create update]
  end

  root 'homepage#index'
  get '/*path' => 'homepage#index'
end
