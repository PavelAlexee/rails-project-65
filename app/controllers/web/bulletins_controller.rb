class Web::BulletinsController < Web::ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    @q = Bulletin.ransack(params[:q])
    @bulletins = @q.result(distinct: true)
                   .where(state: :published)
                   .order(created_at: :desc)
                   .page(params[:page])
                   .per(20)
    set_categories
  end

  def new
    @bulletin = current_user.bulletins.new
    authorize @bulletin
    set_categories
  end

  def show
    @bulletin = Bulletin.find(params[:id])
    authorize(@bulletin)
  end

  def create
    @bulletin = current_user.bulletins.new(bulletin_params)
    authorize @bulletin
    set_categories

    if @bulletin.save
      redirect_to @bulletin, notice: t("flash.bulletins.create.success")
    else
      render :new, status: :unprocessable_content
    end
  end

  def edit
    @bulletin = Bulletin.find(params[:id])
    authorize(@bulletin)
    set_categories
  end

  def update
    @bulletin = Bulletin.find(params[:id])
    authorize(@bulletin)

    if @bulletin.update(bulletin_params)
      redirect_to profile_path, notice: t("flash.bulletins.update.success")
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def to_moderate
    bulletin = Bulletin.find(params[:id])
    authorize(bulletin)

    if bulletin.may_to_moderate?
      bulletin.to_moderate!
      redirect_to profile_path, notice: t("flash.bulletins.to_moderate.success")
    else
      redirect_to profile_path, alert: t("flash.bulletins.to_moderate.failure")
    end
  end

  def reject
    bulletin = Bulletin.find(params[:id])
    authorize(bulletin)

    if bulletin.may_reject?
      bulletin.reject!
      redirect_to profile_path, notice: t("flash.bulletins.reject.success")
    else
      redirect_to profile_path, alert: t("flash.bulletins.reject.failure")
    end
  end

  def archive
    bulletin = Bulletin.find(params[:id])
    authorize(bulletin)

    if bulletin.may_archive?
      bulletin.archive!
      redirect_to profile_path, notice: t("flash.bulletins.archive.success")
    else
      redirect_to profile_path, alert: t("flash.bulletins.archive.failure")
    end
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image, :category_id)
  end

  def set_categories
    @categories = Category.all
  end
end
