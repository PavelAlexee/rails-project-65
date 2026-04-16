# frozen_string_literal: true

module Web
  module Admin
    class ApplicationController < Web::ApplicationController
      before_action :authenticate_user!
      before_action :check_admin!

      private

      def check_admin!
        return if current_user&.admin?

        redirect_to root_path, alert: t('flash.access_denied')
      end
    end
  end
end
