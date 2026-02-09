class Web::BulletinsController < ApplicationController
  before_action :authenticate_user!, only: %i[new show create]

  def index
    @bulletins = Bulletin.recent
  end

  def new
    @bulletin = current_user.bulletins.new
    set_categories
  end

  def create
    @bulletin = current_user.bulletins.new(bulletin_params)
    set_categories


    if @bulletin.save
      redirect_to @bulletin, notice: "Объявление успешно сохранено!"
    else
      render :new, notice: "Объявление не сохранено!" # status: :unprocessable_entity
    end
  end

  def show
    @bulletin = Bulletin.find(params[:id])
  end

  private

  def bulletin_params
    params.expect(bulletin: [ :title, :description, :image, :category_id ])
  end

  def set_categories
    @categories = Category.all
  end
end
