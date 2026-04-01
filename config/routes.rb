# frozen_string_literal: true

Rails.application.routes.draw do
  scope module: :web do
    root 'bulletins#index'

    post 'auth/:provider', to: 'auth#request', as: :auth_request
    get 'auth/:provider/callback', to: 'auth#callback', as: :callback_auth
    delete 'auth/logout', to: 'auth#destroy'

    resource :profile, controller: 'profiles', only: %i[ show create destroy ]

    resources :bulletins, only: %i[index new create edit update show] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    namespace :admin do
      root 'home#index'

      resources :home, only: [:index]

      resources :bulletins, only: :index do
        member do
          patch :archive
          patch :publish
          patch :reject
        end
      end
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
