class Web::BulletinsController < Web::ApplicationController
  include Pundit::Authorization

  before_action :authenticate_user!, only: %i[new create]

  def index
    @bulletins = Bulletin.recent
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
      redirect_to @bulletin, notice: "Объявление успешно сохранено!"
    else
      render :new, notice: "Объявление не сохранено!" # status: :unprocessable_entity
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
      redirect_to profile_path, notice: "Объявление успешно обновлено!"
    else
      render :edit, notice: "Объявление не сохранено!" # status: :unprocessable_entity
    end
  end

  def to_moderate
    bulletin = Bulletin.find(params[:id])
    authorize(bulletin)

    if bulletin.to_moderate!
      redirect_to profile_path, notice: "Объявление отправлено на модерацию"
    else
      redirect_to profile_path, alert: "Не удалось отправить на модерацию"
    end
  end

  def reject
    bulletin = Bulletin.find(params[:id])
    authorize(bulletin)

    if bulletin.reject!
      redirect_to profile_path, notice: "Объявление отклонено"
    else
      redirect_to profile_path, alert: "Не удалось отклонить"
    end
  end


  def archive
    bulletin = Bulletin.find(params[:id])
    authorize(bulletin)

    if bulletin.archive!
      redirect_to profile_path, notice: "Объявление перемещено в архив"
    else
      redirect_to profile_path, alert: "Не удалось переместить в архив"
    end
  end

  private

  def bulletin_params
    params.expect(bulletin: [ :title, :description, :image, :category_id ])
  end

  def set_categories
    @categories = Category.all
  end
end
