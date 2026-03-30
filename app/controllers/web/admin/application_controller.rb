class Web::Admin::ApplicationController < Web::ApplicationController
  # before_action :check_admin!
  # before_action :authenticate_user!

  helper_method :check_admin!

  private

  def check_admin!
    unless current_user&.admin?
      redirect_to root_path, alert: t("flash.access_denied")
    end
  end
end
