require 'sidekiq/web'
Rails.application.routes.draw do
  get '/new' => 'home#new_uploads', as: :home_new

  get '/collections' => 'home#collections', as: :home_collections

  root to: 'home#index'

  devise_for :users

  resources :users, only: [:show, :edit, :update]
  resources :pictures, only: [:create, :index, :new, :edit, :update, :show]

  mount Sidekiq::Web => '/sidekiq'
  mount StatusPage::Engine => '/'

  # mount ActionCable.server => '/cable'

  get '/exif' => 'pictures#exif'

  get '/pages/*id' => 'pages#show', as: :page, format: false

  mount RailsAdmin::Engine => '/helloadmin', as: 'rails_admin'

  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
