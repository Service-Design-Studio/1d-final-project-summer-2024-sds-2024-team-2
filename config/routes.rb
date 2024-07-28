# frozen_string_literal: true

Rails.application.routes.draw do

  root 'user_particulars#show' # set root path of web app as /user_particulars/show for now

  devise_for :users, controllers: {
    registrations: 'users/registrations/registrations',
    passwords: 'users/registrations/passwords'
  }

  # Self-declared extra routes (must be before resources)
  get 'user_particulars/confirm'
  post 'user_particulars/:id/generate_2fa', to: 'user_particulars#generate_2fa', as: 'generate_2fa'
  get 'user_particulars/:id/history', to: 'user_particulars#history', as: 'user_history'
  get 'user_particulars/:id/document', to: 'user_particulars#document', as: 'user_document'
  get 'user_particulars/:id/ngocontact', to: 'user_particulars#ngocontact', as: 'ngocontact'
  get 'user_particulars/family'
  # Resources: UserParticulars
  resources :user_particulars do
    member do
      get 'page2'
    end
  end

  resources :ngo_users do
    member do
      post 'check_user' # Add this line for post action to verify user
      get 'verify', to: 'ngo_users#verify', as: 'verify' # Add this line for the verify action
      post 'verify', to: 'ngo_users#verify'
      post 'confirm_verify', to: 'ngo_users#confirm_verify'
    end
  end

  resources :bulletins


end
