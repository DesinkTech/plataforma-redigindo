class ThemesController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_theme, only: [:edit, :update, :destroy]
  before_action :category_options, only: [:new, :create, :edit, :update]


  def index
    @categories = Category.all
  end

  def new
    @theme = Theme.new
  end

  def create
    @theme = Theme.new(theme_params)

    if @theme.save
      redirect_to themes_path, success: "Tema criado com sucesso"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @theme.update(theme_params)
      redirect_to themes_path, success: "Tema alterado com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @theme.destroy
  end

  private 

  def theme_params
    params.require(:theme).permit(:description, :support_material, :category_id)
  end

  def set_theme
    @theme = Theme.find_by(id: params[:id])
  end

  def category_options
    @category_options = Category.all.pluck(:description, :id)
  end
end
