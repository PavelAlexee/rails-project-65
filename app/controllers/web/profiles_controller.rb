class Web::ProfilesController < Web::ApplicationController
  before_action :authenticate_user!

  def show
    @q = current_user.bulletins.ransack(params[:q])

    @bulletins = @q.result(distinct: true)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(20)

    @aasm = Bulletin.aasm.states
  end

  def make_admin
    current_user.update(admin: true)
    redirect_to profile_path, notice: t("flash.profiles.make_admin.success")
  end

  def remove_admin
    current_user.update(admin: false)
    redirect_to profile_path, notice: t("flash.profiles.remove_admin.success")
  end
end
