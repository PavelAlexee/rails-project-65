class Web::BulletinsController < ApplicationController
  def index
    @bulletins = Bulletin.recent
  end

  def new
    # @bulletin = current_user.bulletins.new
    @bulletin = Bulletin.new
  end

  def create
    # @bulletin = current_user.bulletins.new(bulletin_params)
    @bulletin = Bulletin.new(bulletin_params)


    if @bulletin.save
      redirect_to @bulletins, notice: "Объявление успешно сохранено!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def bulletin_params
    params.expect(billetin: [ :title, :description, :image ])
  end
end
