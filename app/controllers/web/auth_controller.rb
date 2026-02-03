module Web
  class AuthController < ApplicationController
    def callback
      auth_hash = request.env["omniauth.auth"]
      github_uid = auth_hash.uid
      email = auth_hash.info.email
      name = auth_hash.info.name

      user = User.find_or_initialize_by(name:, email:, github_uid:)

      if user.save
        session[:user_id] = user.id
        redirect_to root_path, notice: "Успешный вход!"
      else
        redirect_to root_path, alert: "Ошибка аутентификации"

      end
      # debugger
      #
    end
  end
end
