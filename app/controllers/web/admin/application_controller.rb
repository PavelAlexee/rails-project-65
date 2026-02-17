class Web::Admin::ApplicationController < Web::ApplicationController
  helper_method :requeres_authentication

  private

  def requeres_authentication
    redirect_to root_path, alert: "Только для зарегистрированных пользователей" unless signed_in?
  end
end
