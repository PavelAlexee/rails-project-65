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
    authorize @bulletin
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


  private

  def bulletin_params
    params.expect(bulletin: [ :title, :description, :image, :category_id ])
  end

  def set_categories
    @categories = Category.all
  end
end
