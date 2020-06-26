class EssaysController < ApplicationController
  require 'mini_magick'

  before_action :require_login
  before_action :require_admin, only: [:index]
  before_action :require_student, except: [:index]
  before_action :set_essay, only: [:destroy]
  before_action :fill_themes
  before_action :require_credits, only: [:new, :submit, :create]

  def index
    @essays = Essay.includes(:student, :category, :theme).paginate(page: params[:page], per_page: 16)
    .where(active: true)
    .order(submission_date: 'desc')
  end

  def new
  end

  def submit
    @essay = Essay.new
    @theme = Theme.find_by(hash_id: params[:theme_hash_id])
  end

  def create
    @essay = Essay.new(essay_params)
    @essay.student_id = current_user.student.id
    @essay.category_id = current_user.student.category_id
    @essay.theme_id = Theme.find_by(hash_id: params[:theme_hash_id]).id
    @essay.student.submissions += 1
    @essay.student.credits -= 1

    # Image transformation
    essay_image = MiniMagick::Image.new(essay_params[:file].tempfile.path)
    essay_image.resize '794x1123'
    essay_image.colorspace 'Gray'
    essay_image.contrast
    essay_image.auto_orient
    essay_image.strip

    if @essay.save && @essay.student.save
      redirect_to submissions_path, success: "Redação enviada com sucesso"
    else
      redirect_to submit_essay_path(params[:theme_hash_id]), error: "Tipo de arquivo inválido"
    end
  end

  def download
    send_file("#{Rails.root}/public/docs/redigindo_essay_model.pdf", filename: "redigindo_essay_model.pdf", type: :pdf)
  end


  def destroy
    if @essay && @essay.active
      @essay.student.submissions -= 1
      if @essay.student.save
        @essay.destroy
        redirect_to submissions_path, success: "Redação removida com sucesso"
      end
    else
      redirect_to submissions_path
    end
  end

  private

  def essay_params
    params.fetch(:essay, {}).permit(:file)
  end

  def set_essay
    @essay = Essay.find_by(hash_id: params[:essay_hash_id])
  end

  def fill_themes
    @themes = Theme.where(category_id: current_user.student.category_id).paginate(page: params[:page], per_page: 9)
  end
end
