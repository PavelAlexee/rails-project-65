class Web::Admin::BulletinsController < Web::Admin::ApplicationController
  include Pundit::Authorization

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(20)
    @aasm = Bulletin.aasm.states_for_select
    # authorize @bulletins
  end

  def on_moderate
    @bulletins = Bulletin.where(state: :under_moderation)
                          .order(created_at: :desc)
                          .page(params[:page])
                          .per(20)
    # authorize(@bulletins)
  end

  def publish
    bulletin = Bulletin.find(params[:id])
    # authorize(bulletin)

    if bulletin.publish!
      redirect_to on_moderate_admin_bulletins_path, notice: "Объявление опубликовано"
    else
      redirect_to on_moderate_admin_bulletins_path, alert: "Не удалось опубликовать объявление"
    end
  end

  def reject
    bulletin = Bulletin.find(params[:id])
    # authorize(bulletin)

    if bulletin.reject!
      redirect_to on_moderate_admin_bulletins_path, notice: "Объявление возвращено на доработку"
    else
      redirect_to on_moderate_admin_bulletins_path, alert: "Не удалось вернуть на доработку"
    end
  end


  def archive
    bulletin = Bulletin.find(params[:id])
    # authorize(bulletin)

    return_path = params[:return_to].presence || root_path

    if bulletin.archive!
      redirect_to return_path, notice: "Объявление перемещено в архив"
    else
      redirect_to return_path, alert: "Не удалось переместить в архив"
    end
  end
end
