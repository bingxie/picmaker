require 'sidekiq/web'
Rails.application.routes.draw do

  resources :pictures, only: [:create, :new, :show]

  # writer your routes here

  mount Sidekiq::Web => '/sidekiq'
  mount StatusPage::Engine => '/'
  #mount ActionCable.server => '/cable'
  root to: 'visitors#index'
end
