Rails.application.routes.draw do
  scope module: :web do
    root "bulletins#index"

    post "auth/:provider", to: "auth#request", as: :auth_request
    get "auth/:provider/callback", to: "auth#callback", as: :callback_auth
    delete "auth/logout", to: "auth#destroy"

    resources :bulletins, only: %i[index new create edit show]

    namespace :admin do
        resources :bulletins, only: :index
        resources :categories, only: %i[index new create edit update destroy]
    end
  end
end
