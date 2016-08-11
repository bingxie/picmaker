require 'sidekiq/web'
Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/helloadmin', as: 'rails_admin'
  resources :pictures, only: [:create]

  # writer your routes here

  mount Sidekiq::Web => '/sidekiq'
  mount StatusPage::Engine => '/'

  # mount ActionCable.server => '/cable'

  root to: 'pictures#index'
end
