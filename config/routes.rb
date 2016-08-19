require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users

  resources :pictures, only: [:create, :index]

  mount Sidekiq::Web => '/sidekiq'
  mount StatusPage::Engine => '/'

  # mount ActionCable.server => '/cable'

  root to: 'pictures#new'

  get "/pages/*id" => 'pages#show', as: :page, format: false

  mount RailsAdmin::Engine => '/helloadmin', as: 'rails_admin'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
