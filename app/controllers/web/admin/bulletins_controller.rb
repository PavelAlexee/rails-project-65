class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(20)
    @aasm = Bulletin.aasm.states_for_select
  end

  def on_moderate
    @bulletins = Bulletin.where(state: :under_moderation)
                          .order(created_at: :desc)
                          .page(params[:page])
                          .per(20)
  end

  def publish
    bulletin = Bulletin.find(params[:id])

    if bulletin.may_publish?
      bulletin.publish!
      redirect_to on_moderate_admin_bulletins_path, notice: t("flash.bulletins.to_moderate.success")
    else
      redirect_to on_moderate_admin_bulletins_path, alert: t("flash.bulletins.to_moderate.failure")
    end
  end

  def reject
    bulletin = Bulletin.find(params[:id])

    if bulletin.may_reject?
      bulletin.reject!
      redirect_to on_moderate_admin_bulletins_path, notice: t("flash.bulletins.reject.success")
    else
      redirect_to on_moderate_admin_bulletins_path, alert: t("flash.bulletins.reject.failure")
    end
  end

  def archive
    bulletin = Bulletin.find(params[:id])

    return_path = params[:return_to].presence || root_path

    if bulletin.may_archive?
      bulletin.archive!
      redirect_to return_path, notice: t("flash.bulletins.archive.success")
    else
      redirect_to return_path, alert: t("flash.bulletins.archive.failure")
    end
  end
end
