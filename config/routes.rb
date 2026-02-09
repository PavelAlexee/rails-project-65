Rails.application.routes.draw do
  scope module: :web do
    root "bulletins#index"

    post "auth/:provider", to: "auth#request", as: :auth_request
    get "auth/:provider/callback", to: "auth#callback", as: :callback_auth
    delete "auth/logout", to: "auth#destroy"

    resources :bulletins, only: [ :index, :create, :new, :show ]
  end
end
