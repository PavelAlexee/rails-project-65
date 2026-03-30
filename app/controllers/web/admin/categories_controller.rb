class Web::Admin::CategoriesController < Web::Admin::ApplicationController
  def index
    @categories = Category.all
                          .page(params[:page])
                          .per(20)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to admin_categories_path, notice: t("flash.admin.categories.create.success")
    else
      flash.now[:alert] = t("flash.admin.categories.create.failure")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    set_category
  end

  def update
    set_category
    if @category.update(category_params)
      redirect_to admin_categories_path, notice: t("flash.admin.categories.update.success")
    else
      flash.now[:alert] = t("flash.admin.categories.update.failure")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    set_category

    if @category.bulletins.exists?
      redirect_to admin_categories_path, alert: t("flash.admin.categories.destroy.has_bulletins")
    elsif @category.destroy
      redirect_to admin_categories_path, notice: t("flash.admin.categories.destroy.success")
    else
      flash.now[:alert] = t("flash.admin.categories.destroy.failure")
      redirect_to admin_categories_path, alert: t("flash.admin.categories.destroy.failure")
    end
  end

  private

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(:name)
  end
end
