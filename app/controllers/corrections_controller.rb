class CorrectionsController < ApplicationController
  layout "correction", only: [:start, :validate]
  before_action :require_login
  before_action :require_admin, except: [:show]
  before_action :set_correction, only: [:show, :start, :update, :finish]
  before_action :valid_correction?, :set_competences, only: [:start]
  before_action :set_essay, only: [:validate, :create]

  def index
    corrections = Correction.includes(:student, :essay, :reviewer, :admin)
    

    @correcting = corrections.where(end_date: nil).where.not(start_date: nil).order(start_date: 'desc')
    @correcting_count = @correcting.count
    @correcting = @correcting.limit(25)

    @corrected = corrections.where.not(start_date: nil, end_date: nil).order(end_date: 'desc')
    @corrected_count = @corrected.count
    @corrected = @corrected.paginate(page: params[:page], per_page: 16)
  end

  def show
  end
  
  def new
    @essays = Essay.includes(:student, :theme, :category).where(active: true)
    @ifrn = @essays.where(categories: { description: 'IFRN' })
    @enem = @essays.where(categories: { description: 'ENEM' })
  end

  def validate
    @correction = Correction.new
  end
  
  def create
    @correction = Correction.new
    @correction.essay_id = @essay.id
    @correction.student_id = @essay.student_id
    @correction.start_date = DateTime.current
    @essay.toggle :active

    if current_user.admin?
      @correction.admin_id = current_user.admin.id
    else
      @correction.reviewer_id = current_user.reviewer.id
    end

    if correction_params[:valid_essay] == 'false'
      @correction.start_date = @correction.end_date = DateTime.current
      @correction.toggle :valid_essay
      @correction.final_score = 0
      
      if @correction.save && @essay.save
        redirect_to corrections_path, success: "Correção finalizada com sucesso"
      end
    elsif @correction.save && @essay.save
      redirect_to start_correction_path(@correction.hash_id)
    end
  end

  def start
    # @correction.reload
  end

  def update
    @comment = Comment.find_by(id: params[:comment])


    if correction_params[:essay_line].empty?
      redirect_to start_correction_path(@correction.hash_id), error: "A linha deve ser preenchida"
    elsif correction_params[:text_cut].empty?
      redirect_to start_correction_path(@correction.hash_id), error: "O recorte de texto deve ser especificado"
    else
      cc = @correction.correction_comments.create({
        correction_id: @correction.id,
        comment_id: @comment.id,
        essay_line: correction_params[:essay_line],
        text_cut: correction_params[:text_cut],
        penalty: correction_params[:penalty]
      })
        
      if cc.errors.any?
        redirect_to start_correction_path(@correction.hash_id), error: cc.errors.full_messages.sample
      else
        redirect_to start_correction_path(@correction.hash_id)
      end
    end

  end

  def finish
    if current_user.admin?
      @correction.admin_id = current_user.id
      @correction.admin.reviewed += 1
    else
      @correction.reviewer_id = current_user.id
      @correction.reviewer.reviewed += 1
    end

    
    @correction.end_date = DateTime.current
    @correction.student.reviewed_submissions += 1
    @correction.final_comment = correction_params[:final_comment]

    if @correction.save && @correction.admin.save && @correction.student.save
      redirect_to corrections_path, success: "Correção finalizada com sucesso"
    end
  end

  private

  def correction_params
    params.require(:correction).permit(:valid_essay, :essay_line, :text_cut, :final_comment, :penalty)
  end

  def set_correction
    @correction = Correction.find_by(hash_id: params[:correction_hash_id])
  end

  def set_essay
    @essay = Essay.find_by(hash_id: params[:essay_hash_id])
  end

  def set_competences
    @competences = CorrectionCompetence.where(correction_id: @correction.id).all
  end

  def valid_correction?
    redirect_to corrections_path, warning: "Correção já finalizada" unless set_correction.end_date.nil?
  end
end
