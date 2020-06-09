class CategoriesController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_category, except: [:index, :new]

  def index
    @categories = Category.paginate(page: params[:page], per_page: 25)
  end

  def show
    @competences = @category.competences.paginate(page: params[:page], per_page: 25)
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to categories_path, success: "Categoria criada com sucesso"
    else
      render :new
    end
  end

  def edit
  end
  
  def update
    if @category.update(category_params)
      redirect_to categories_path, success: "Categoria alterada com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @category.destroy
  end

  private

  def category_params
    params.require(:category).permit(:description, :max_score)
  end

  def set_category
    @category = Category.find_by(id: params[:id])
  end
end
