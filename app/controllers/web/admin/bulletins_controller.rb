# frozen_string_literal: true

module Web
  module Admin
    class BulletinsController < Web::Admin::ApplicationController
      def index
        @q = Bulletin.ransack(params[:q])
        @bulletins = @q.result(distinct: true)
                       .order(created_at: :desc)
                       .page(params[:page])
                       .per(20)
        @aasm_options = aasm_options
      end

      def publish
        bulletin = Bulletin.find(params[:id])

        if bulletin.may_publish?
          bulletin.publish!
          redirect_to admin_root_path, notice: t('flash.bulletins.to_moderate.success')
        else
          redirect_to admin_root_path, alert: t('flash.bulletins.to_moderate.failure')
        end
      end

      def reject
        bulletin = Bulletin.find(params[:id])

        if bulletin.may_reject?
          bulletin.reject!
          redirect_to admin_root_path, notice: t('flash.bulletins.reject.success')
        else
          redirect_to admin_root_path, alert: t('flash.bulletins.reject.failure')
        end
      end

      def archive
        bulletin = Bulletin.find(params[:id])

        return_path = params[:return_to].presence || admin_root_path

        if bulletin.may_archive?
          bulletin.archive!
          redirect_to return_path, notice: t('flash.bulletins.archive.success')
        else
          redirect_to return_path, alert: t('flash.bulletins.archive.failure')
        end
      end

      private

      def aasm_options
        Bulletin.aasm.states.map do |state|
          [I18n.t("aasm.state.bulletin.#{state.name}"), state.name.to_s]
        end
      end
    end
  end
end
