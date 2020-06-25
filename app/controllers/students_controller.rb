class StudentsController < ApplicationController
  layout "login", only: [:new, :create]
  before_action :require_logout, only: [:new, :create]
  before_action :require_login, only: [:index, :show, :edit, :update, :activate, :deactivate, :destroy]
  before_action :require_admin, only: [:index, :show, :deactivate, :activate, :destroy]
  before_action :require_student, only: [:edit, :update]
  before_action :address_options, :school_options, :classroom_options, :category_options, only: [:new, :create, :edit, :update]
  before_action :set_student, except: [:index, :new, :create]

  def index
    @students = Student.includes(:category, :school, user: :address).paginate(page: params[:page], per_page: 16)
      .where(users: { verified: true })
  end

  def show
  end

  def new
    @student = Student.new
    @student.build_user
  end

  def create
    @student = Student.new(student_params)

    if @student.save
      @student.user.send_verification_email
      redirect_to root_path, info: "Link de verificação enviado, consulte seu email para obtê-lo"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to edit_student_path(@student.user.username.delete(" ").downcase), success: "Perfil atualizado com sucesso"
    else
      flash.now[:error] = "Erro ao atualizar perfil"
      render :edit
    end
  end

  def activate
    unless @student.user.active?
      @student.user.toggle(:active)
      redirect_to home_path, error: "Erro ao ativar usuário" unless @student.save
      redirect_to classroom_path(@student.classroom)
    end
  end

  def deactivate
    if @student.user.active?
      @student.user.toggle(:active)
      redirect_to home_path, error: "Erro ao desativar usuário" unless @student.save
      redirect_to classroom_path(@student.classroom)
    end
  end

  def destroy
    @student.destroy
    redirect_to classroom_path(@student.classroom), success: "Aluno removido com sucesso"
  end

  private

  def set_student
    @student = current_user.student || Student.find_by(id: params[:student_id])
  end

  def student_params
    params.require(:student).permit(:classroom_id, :school_id, :category_id, user_attributes: [:id, :email, :username, :password, :password_confirmation,
                                                                                :name, :birth_date, :cpf, :address_id])
  end

  def address_options
    @address_options = Address.all.pluck(:city, :id)
  end

  def category_options
    @category_options = Category.all.pluck(:description, :id)
  end

  def school_options
    @school_options = School.all.pluck(:name, :id)
  end

  def classroom_options
    @classroom_options = Classroom.all.pluck(:name, :id)
  end
end
