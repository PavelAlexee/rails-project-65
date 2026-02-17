class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  before_action :requeres_authentication
  before_action :authenticate_user!

  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: "Категория успешно создана!"
    else
      render :new, notice: "Категория не сохранена!" # status: :unprocessable_entity
    end
  end

  def edit
    set_category
  end

  def update
    set_category
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: "Категория успешно обновлена!"
    else
      render :edit, notice: "Категория не сохранена!" # status: :unprocessable_entity
    end
  end

  def destroy
    set_category
    @category.destroy
    redirect_to admin_categories_path, notice: "Категория успешно удалена!"
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.expect(category: [ :name ])
  end
end
