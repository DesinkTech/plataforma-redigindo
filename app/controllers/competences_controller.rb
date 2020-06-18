class CompetencesController < ApplicationController
  before_action :require_login, :require_admin
  before_action :set_competence, except: [:index]
  before_action :abs_max_penalty, only: [:edit, :update]

  def index
    @competences = Competence.paginate(page: params[:page], per_page: 16)
  end

  def show
    @comments = @competence.comments.paginate(page: params[:page], per_page: 16)
  end

  def new
    @competence = Competence.new
    @competence.category = Category.find_by(id: params[:category])
  end

  def create
    @competence = Competence.new(competence_params)

    if @competence.save
      redirect_to category_path(@competence.category), success: "Competência criada com sucesso"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @competence.update(competence_params)
      redirect_to category_path(@competence.category), success: "Competência alterada com sucesso"
    else
      render :edit
    end
  end

  def destroy
    @competence.destroy
  end

  private

  def competence_params
    params.require(:competence).permit(:description, :max_penalty, :penalty_division, :category_id)
  end

  def set_competence
    @competence = Competence.find_by(id: params[:id])
  end

  def abs_max_penalty
    @competence.max_penalty = @competence.max_penalty.abs
  end 
end
