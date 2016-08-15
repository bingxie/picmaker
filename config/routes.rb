require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :users
  mount RailsAdmin::Engine => '/helloadmin', as: 'rails_admin'

  resources :pictures, only: [:create, :index]

  mount Sidekiq::Web => '/sidekiq'
  mount StatusPage::Engine => '/'

  # mount ActionCable.server => '/cable'

  root to: 'pictures#new'

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
end
