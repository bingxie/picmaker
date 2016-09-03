require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users

  resources :pictures, only: [:create, :index, :new]

  mount Sidekiq::Web => '/sidekiq'
  mount StatusPage::Engine => '/'

  # mount ActionCable.server => '/cable'

  root to: 'pictures#border'

  get '/pages/*id' => 'pages#show', as: :page, format: false

  mount RailsAdmin::Engine => '/helloadmin', as: 'rails_admin'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
