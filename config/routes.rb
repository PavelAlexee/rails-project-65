Rails.application.routes.draw do
  namespace :web do
    get "users/profile"
  end
  scope module: :web do
    root "bulletins#index"

    post "auth/:provider", to: "auth#request", as: :auth_request
    get "auth/:provider/callback", to: "auth#callback", as: :callback_auth
    delete "auth/logout", to: "auth#destroy"

    get "profile", to: "users#profile", as: :profile

    resources :bulletins, only: %i[index new create edit update show] do
      member do
        patch :to_moderate
        patch :archive
      end
    end

    namespace :admin do
        resources :bulletins, only: :index do
          collection do
            get :on_moderate
          end

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
