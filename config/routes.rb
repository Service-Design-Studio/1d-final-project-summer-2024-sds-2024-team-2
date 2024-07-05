# frozen_string_literal: true

Rails.application.routes.draw do
  root 'user_particulars#show' # set root path of web app as /user_particulars/show for now

  devise_for :users, controllers: {
    registrations: 'users/registrations/registrations',
    passwords: 'users/registrations/passwords'
  }

  # Self-declared extra routes (must be before resources)
  get 'user_particulars/confirm'
  get 'ngo_users/verify'
  # Resources: UserParticulars
  resources :user_particulars
  resources :ngo_users
end
